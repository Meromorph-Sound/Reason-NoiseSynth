/*
 * Clicker.cpp
 *
 *  Created on: 31 Jan 2021
 *      Author: julianporter
 */

#include "Clicker.hpp"

namespace meromorph {
namespace click {



const float32 Clicker::TriggerPeriod = 0.1;

Clicker::Clicker() : RackExtension() {
	trace("Clicker is here");
	computeTriggerDelay();
	right=JBox_GetMotherboardObjectRef("/audio_outputs/audioOutRight");
	left=JBox_GetMotherboardObjectRef("/audio_outputs/audioOutLeft");
	externalTrigger=JBox_GetMotherboardObjectRef("/cv_inputs/externalTrigger");
}

void Clicker::processApplicationMessage(const TJBox_PropertyDiff &diff) {
	Tag tag = diff.fPropertyTag;
	switch(tag) {
	case Tags::TRIGGER:
		trace("Trigger fired");
		if(toBool(diff.fCurrentValue)) triggered=true;
		break;
	case Tags::TRIGGER_MODE:
		trace("Trigger mode ^0",toFloat(diff.fCurrentValue));
		break;
	}
}


void Clicker::computeTriggerDelay() {
	auto chunkCount = sampleRate/(float32)BUFFER_SIZE;
	auto nChunks = chunkCount*Clicker::TriggerPeriod;
	triggerDelay = (uint32)nChunks;
	trace("Trigger Delay is ^0",triggerDelay);
}
void Clicker::handleTriggerLED() {
	if(triggered) {
		trace("Starting trigger");
		triggeredCount=triggerDelay;
		set(1,Tags::TRIGGER_BACK);
	}
	else if(triggeredCount==1) {
		trace("Ending trigger");
		triggeredCount=0;
		set(0,Tags::TRIGGER_BACK);
	}
	else if(triggeredCount>1) {
		if(0 == triggeredCount%10) trace("Decrementing trigger x 10");
		triggeredCount--;
	}
}

void Clicker::setSampleRate(const float32 rate) {
	sampleRate=rate;
	computeTriggerDelay();
}

void Clicker::process() {
	handleTriggerLED();
	triggered=false;
}




} /* namespace click */
} /* namespace meromorph */
