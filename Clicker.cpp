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
			//trace("Starting trigger");
			triggeredCount=triggerDelay;
			return SET;
		}
		else if(triggeredCount==1) {
			//trace("Ending trigger");
			triggeredCount=0;
			return RESET;
		}
		else if(triggeredCount>1) {
			//if(0 == triggeredCount%10) trace("Decrementing trigger x 10");
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
	tState.setDelay(sampleRate,BUFFER_SIZE);
	right=JBox_GetMotherboardObjectRef("/audio_outputs/audioOutRight");
	left=JBox_GetMotherboardObjectRef("/audio_outputs/audioOutLeft");
	externalTrigger=JBox_GetMotherboardObjectRef("/cv_inputs/externalTrigger");

}


TriggerMode asMode(const TJBox_PropertyDiff & diff) {
	int32 i = toInt(diff.fCurrentValue);
	int32 limited = clamp(0,2,i);
	return static_cast<TriggerMode>(limited);
}


void Clicker::processApplicationMessage(const TJBox_PropertyDiff &diff) {
	Tag tag = diff.fPropertyTag;

	switch(tag) {
	case Tags::SHAPE: {
		trace("Shape fired");
		click = Clicks::asShape(diff);
		break;
	}
	case Tags::PITCH: {
		auto f = scaledFloat(diff.fCurrentValue,PITCH_MIN,PITCH_MAX);
		trace("Carrier frequency is ^0",f);
		carrier.setFrequency(f);
		break;
	}
	case Tags::LENGTH: {
		clickLength = lround(scaledFloat(diff.fCurrentValue,LENGTH_MIN,LENGTH_MAX));
		clicks.setScale(clickLength);
		trace("Click length is ^0",clickLength);
		break;
	}
	case Tags::PAN: {
		auto angle = scaledFloat(diff.fCurrentValue,0,meromorph::Pi/2);
		lPan = cos(angle);
		rPan = sin(angle);
		trace("Pan angle is ^0",angle);
		break;
	}
	case Tags::AMPLITUDE:
		amplitude = clampedFloat(diff.fCurrentValue);
		trace("Amplitude is ^0",amplitude);
		break;

	case Tags::LIMITER: {
		auto l = clampedFloat(diff.fCurrentValue);
		limiter.setLimit(pow(10.f,l));
		break;
	}
	case Tags::LIMITER_ONOFF:
		limiter.setActive(toBool(diff.fCurrentValue));
		break;
	case Tags::LIMITER_HARD_SOFT: {
		auto mode = toBool(diff.fCurrentValue) ? Limiter::HARD : Limiter::SOFT;
		limiter.setMode(mode);
		break;
	}
	case Tags::LFO_FREQUENCY: {
		auto freq = scaledFloat(diff.fCurrentValue,0,750);
		trace("Setting pulse to ^0",freq);
		pulse.setFrequency(freq);
		break; }
	case Tags::LFO_HOLD:
		pulse.hold(toBool(diff.fCurrentValue));
		break;
	case Tags::LFO_MODULATOR_ONOFF:
		break;

	case Tags::TRIGGER:
		if(mode==TriggerMode::MANUAL) {
			if(toBool(diff.fCurrentValue)) shouldTrigger=true;
		}
		break;
	case Tags::TRIGGER_MODE:
		trace("Trigger mode ^0",toFloat(diff.fCurrentValue));
		mode = asMode(diff);
		if(mode==TriggerMode::EXT_CLOCK) edges.reset();
		break;
	case kJBox_CVInputValue:
		if(mode==TriggerMode::EXT_CLOCK) {
			if(edges(toFloat(diff.fCurrentValue))) shouldTrigger=true;
		}
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
	trace("Sample rate is ^0",rate);
}

void Clicker::process() {
	if(!initialised) {
		clicks.setScale(clickLength);
		initialised=true;
	}

	auto p = pulse.next();
	if(mode==TriggerMode::INT_CLOCK) {
		shouldTrigger=p>0;
		//if(p>0) trace("Triggering internal");
	}

	if(shouldTrigger) {
		//trace("Triggering pulse, mode is ^0",mode);
		tState.set();
		shouldTrigger=false;
	}


	if(tState.isTriggered()) {
		clicking=true;
		clickOffset=0;
	}
	//if(clicking) trace("Clicking ON  Click offset is ^0",clickOffset);


	if(clicking && clickOffset>=clickLength) {
		clicking=false;
		clickOffset=0;
	}

	for(auto n=0;n<BUFFER_SIZE;n++) {
		auto c = (clicking) ? clicks.at(click,clickOffset++) : 0.f;
		auto f = carrier.next();
		auto sample=c*f*amplitude;

		lBuffer[n]=sample*lPan;
		rBuffer[n]=sample*rPan;
	}

	limiter.limit(lBuffer);
	limiter.limit(rBuffer);

	auto refL = JBox_LoadMOMPropertyByTag(left, kJBox_AudioOutputBuffer);
	JBox_SetDSPBufferData(refL, 0, lBuffer.size(), lBuffer.data());

	auto refR = JBox_LoadMOMPropertyByTag(right, kJBox_AudioOutputBuffer);
	JBox_SetDSPBufferData(refR, 0, rBuffer.size(), rBuffer.data());

	handleTriggerLED();
	tState.clear();


}




} /* namespace click */
} /* namespace meromorph */
