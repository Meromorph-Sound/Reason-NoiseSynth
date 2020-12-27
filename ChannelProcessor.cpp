/*
 * ChannelProcessor.cpp
 *
 *  Created on: 26 Dec 2020
 *      Author: julianporter
 */

#include "ChannelProcessor.hpp"
#include <cmath>

namespace meromorph {

NoteEvent::NoteEvent() : note(0), velocity(0), index(0),
		masterTune(1), sampleRate(48000), action(NoteOff) {}

NoteEvent::NoteEvent(const TJBox_NoteEvent &event,const float32 masterTune_,const float32 rate) :
		note(event.fNoteNumber), velocity(event.fVelocity), index(event.fAtFrameIndex),
		masterTune(masterTune_), sampleRate(rate) {
	action = velocity>0 ? NoteOn : NoteOff;
}

float32 NoteEvent::frequency() const {
	return std::powf(2.0f, ((note + masterTune) - 69.0f) / 12.0f) * 440.0f;
}
uint32 NoteEvent::period() const {
	auto f = frequency();
	if(f<=0) return 0;
	else {
		auto p = lround(sampleRate/f);
		return (uint32)p;
	}
}



const uint32 ChannelProcessor::SEQUENCE_SIZE = 8192;
const uint32 ChannelProcessor::BUFFER_SIZE = 64;

TJBox_ObjectRef getRef(const char *base,const char *code) {
	char inP[80];
	append(inP,base,code);
	trace(inP);
	return JBox_GetMotherboardObjectRef(inP);
}

ChannelProcessor::ChannelProcessor(const char *code)
	: rng(-1,1), buffer(ChannelProcessor::BUFFER_SIZE), sequence(SEQUENCE_SIZE) {
	output=getRef("/audio_outputs/audio",code);
	env=JBox_GetMotherboardObjectRef("/transport");
}

float32 ChannelProcessor::getEnvVariable(const uint32 tag) const {
	const TJBox_Value& v = JBox_LoadMOMPropertyByTag(env, tag);
	const TJBox_Float64& n = JBox_GetNumber(v);
	return static_cast<float32>(n);
}

void ChannelProcessor::reset() {
	rng.init(getEnvVariable(kJBox_TransportPlayPos));
	for(auto i=0;i<SEQUENCE_SIZE;i++) sequence[i]=rng();
}


void ChannelProcessor::write() {
	auto ref = JBox_LoadMOMPropertyByTag(output, kJBox_AudioOutputBuffer);
	if(buffer.size()>0) { JBox_SetDSPBufferData(ref, 0, buffer.size(), buffer.data()); }
}





void ChannelProcessor::process(const NoteEvent &n) {
	if(!initialised) {
		reset();
		initialised=true;
	}

	if(n.isOn()) {	// changed to on from silence, or to different note
		if(!isOn || n.note!=note) {
			note=n.note;
			auto period = n.period();
			if(period>0) {
				isOn=true;
				length = std::min(period,SEQUENCE_SIZE);
				sequencePos=0;
			}
		}
	}
	else {	// switch off
		isOn=false;
	}

	if(!isOn) buffer.assign(BUFFER_SIZE,0);
	else if(length>0) {
		for(auto i=0;i<BUFFER_SIZE;i++) {
			buffer[i]=sequence[sequencePos];
			sequencePos = (sequencePos+1) % length;
		}
	}
	write();
}




} /* namespace meromorph */
