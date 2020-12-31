/*
 * ChannelProcessor.cpp
 *
 *  Created on: 26 Dec 2020
 *      Author: julianporter
 */

#include "ChannelProcessor.hpp"
#include <cmath>

namespace meromorph {



const uint32 ChannelProcessor::SEQUENCE_SIZE = 8192;
const uint32 ChannelProcessor::BUFFER_SIZE = 64;


union Converter {
	uint64 i64;
	float64 f64;

	Converter(const float32 f) : f64(f) {};
	operator uint64() { return i64; }
};

ChannelProcessor::ChannelProcessor()
	: rng(-1,1), buffer(ChannelProcessor::BUFFER_SIZE), sequence(SEQUENCE_SIZE) {
	env=JBox_GetMotherboardObjectRef("/transport");
}

float32 ChannelProcessor::getEnvVariable(const uint32 tag) const {
	const TJBox_Value& v = JBox_LoadMOMPropertyByTag(env, tag);
	const TJBox_Float64& n = JBox_GetNumber(v);
	return static_cast<float32>(n);
}

void ChannelProcessor::reset() {
	float32 pos = std::max(1.f,getEnvVariable(kJBox_TransportPlayPos));
	float32 v = (3.9271*pos+12)*(421.956*seed+1);
	trace("Raw is ^0, Seed is ^1",seed, v);
	rng.init(llround(v));
	for(auto i=0;i<SEQUENCE_SIZE;i++) sequence[i]=rng();
	startPos=0;
}





void ChannelProcessor::process(const NoteEvent &n) {
	if(!initialised) {
		reset();
		initialised=true;
	}

	if(n.isOn()) {	/// changed to on from silence, or to different note
		if(!isOn || n.note!=note) {
			note=n.note;
			auto period = n.period();
			if(period>0) {
				isOn=true;
				length = std::min(period,SEQUENCE_SIZE);
				startPos=fmod(startPos+length,SEQUENCE_SIZE);
				sequencePos=0;

				//inc=std::max(0.1f,alpha*powf(length,0.4));
			}
		}
	}
	else {	/// switch off
		isOn=false;
	}

	if(!isOn) buffer.assign(BUFFER_SIZE,0);
	else if(length>0) {
		auto level=n.level();
		inc=std::max(0.001f,alpha*powf(length,exponent));
		//trace("Length is ^0",length);
		auto offset = lround(startPos);
		for(auto i=0;i<BUFFER_SIZE;i++) {
			buffer[i]=sequence[(offset+sequencePos) % SEQUENCE_SIZE]*level;
			sequencePos = (sequencePos+1) % length;
		}
		startPos+=inc; //std::max(1.0f,length/9.0f);
	}
}




} /* namespace meromorph */
