/*
 * Clicker.cpp
 *
 *  Created on: 31 Jan 2021
 *      Author: julianporter
 */

#include "Clicker.hpp"

namespace meromorph {
namespace click {

void TriggerState::setDelay(const float32 sampleRate,const float32 BUFFER_SIZE) {
	auto chunkCount = sampleRate/(float32)BUFFER_SIZE;
		auto nChunks = chunkCount*TriggerState::TriggerPeriod;
		triggerDelay = (uint32)nChunks;
		trace("Trigger Delay is ^0",triggerDelay);
}


TriggerState::Action TriggerState::step() {
	if(triggered) {
			trace("Starting trigger");
			triggeredCount=triggerDelay;
			return SET;
		}
		else if(triggeredCount==1) {
			trace("Ending trigger");
			triggeredCount=0;
			return RESET;
		}
		else if(triggeredCount>1) {
			if(0 == triggeredCount%10) trace("Decrementing trigger x 10");
			triggeredCount--;
		}
	return NIL;
}
void TriggerState::reset() {
	triggerDelay=1;
	triggeredCount=0;
	triggered=false;
}

const float32 TriggerState::TriggerPeriod = 0.1;

Clicker::Clicker() : RackExtension(), lBuffer(BUFFER_SIZE), rBuffer(BUFFER_SIZE) {
	trace("Clicker is here");
	computeTriggerDelay();
	right=JBox_GetMotherboardObjectRef("/audio_outputs/audioOutRight");
	left=JBox_GetMotherboardObjectRef("/audio_outputs/audioOutLeft");
	externalTrigger=JBox_GetMotherboardObjectRef("/cv_inputs/externalTrigger");
}

void Clicker::processApplicationMessage(const TJBox_PropertyDiff &diff) {
	Tag tag = diff.fPropertyTag;
	switch(tag) {
	case Tags::SHAPE: {
		trace("Shape fired");
		auto s = clamp(0,ClickShape::N_SHAPE_FUNCTIONS-1,toInt(diff.fCurrentValue));
		click=clicks[s];
		break;
	}
	case Tags::PITCH:
		carrier.setFrequency(toFloat(diff.fCurrentValue));
		break;
	case Tags::LENGTH:
		clickLength = toInt(diff.fCurrentValue);
		break;
	case Tags::PAN: {
		auto coefft = clamp(-1.f,1.f,toFloat(diff.fCurrentValue));
		auto angle = M_PI*(coefft+1)/4;
		lPan = cos(angle);
		rPan = sin(angle);
		break;
	}
	case Tags::AMPLITUDE:
		amplitude = clamp(0.f,1.f,toFloat(diff.fCurrentValue));
		break;
	case Tags::TRIGGER:
		trace("Trigger fired");
		if(toBool(diff.fCurrentValue)) tState.set();
		break;
	case Tags::TRIGGER_MODE:
		trace("Trigger mode ^0",toFloat(diff.fCurrentValue));
		break;
	}



}

void Clicker::handleTriggerLED() {
	switch(tState.step()) {
	case TriggerState::SET:
		set(1,Tags::TRIGGER_BACK);
		break;
	case TriggerState::RESET:
		set(0,Tags::TRIGGER_BACK);
		break;
	default:
		break;
	}
}

void Clicker::setSampleRate(const float32 rate) {
	sampleRate=rate;
	tState.setDelay(rate,BUFFER_SIZE);
	carrier.setSampleRate(rate);
}

void Clicker::process() {
	if(tState.isTriggered()) {
		clicking=true;
		clickOffset=0;
	}
	if(clicking && clickOffset>=clickLength) {
		clicking=false;
		clickOffset=0;
	}

	for(auto n=0;n<BUFFER_SIZE;n++) {
		auto c = (clicking) ? click[clickOffset++] : 0.f;
		auto f = carrier.next();
		auto sample=c*f*amplitude;

		lBuffer[n]=sample*lPan;
		rBuffer[n]=sample*rPan;
	}
	auto refL = JBox_LoadMOMPropertyByTag(left, kJBox_AudioOutputBuffer);
	JBox_SetDSPBufferData(refL, 0, lBuffer.size(), lBuffer.data());

	auto refR = JBox_LoadMOMPropertyByTag(right, kJBox_AudioOutputBuffer);
	JBox_SetDSPBufferData(refR, 0, rBuffer.size(), rBuffer.data());

	handleTriggerLED();
	tState.clear();


}




} /* namespace click */
} /* namespace meromorph */
