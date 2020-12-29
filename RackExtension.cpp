#include <cmath>
#include <cstring>
#include "RackExtension.hpp"
#include <algorithm>

namespace meromorph {


const uint32 RackExtension::MAX_NOTES = 8;




RackExtension::RackExtension() : notes(MAX_NOTES), buffer(ChannelProcessor::BUFFER_SIZE) {
	noteState = JBox_GetMotherboardObjectRef("/note_states");
	left=JBox_GetMotherboardObjectRef("/audio_outputs/audioL");
	right=JBox_GetMotherboardObjectRef("/audio_outputs/audioR");
	props=JBox_GetMotherboardObjectRef("/custom_properties");
}


void RackExtension::set(const float32 value,const Tag tag) {
	TJBox_Value v = JBox_MakeNumber(static_cast<float64>(value));
	JBox_StoreMOMPropertyByTag(props,tag,v);
}

void RackExtension::process() {
	channel.process(currentNote);
	std::copy(channel.begin(),channel.end(),buffer.begin());

	auto refL = JBox_LoadMOMPropertyByTag(left, kJBox_AudioOutputBuffer);
	JBox_SetDSPBufferData(refL, 0, buffer.size(), buffer.data());

	auto refR = JBox_LoadMOMPropertyByTag(right, kJBox_AudioOutputBuffer);
	JBox_SetDSPBufferData(refR, 0, buffer.size(), buffer.data());

	//float32 mag=0;
	//for(auto it=buffer.begin();it!=buffer.end();it++) mag+=fabs(*it);
	//set(mag*8/(float32)ChannelProcessor::BUFFER_SIZE,Tags::VOLUME);

}



void RackExtension::processMIDIEvent(const TJBox_PropertyDiff &diff) {
	auto event = JBox_AsNoteEvent(diff);
	if(forwarding) JBox_OutputNoteEvent(event); // forwarding notes
	if(notes.update(event)) {
		//trace("Upating note");
		auto on = notes.isOn();
		if(on) currentNote=notes();
		else currentNote.setOff();
		//trace("Current note is ^0 and active ^1",currentNote.note, currentNote.isOn() ? 1 : 0);
		set(on ? 1 : 0,Tags::NOTE);
	}
}

void RackExtension::RenderBatch(const TJBox_PropertyDiff diffs[], TJBox_UInt32 nDiffs) {
	noteCount=0;
	for(auto i=0;i<nDiffs;i++) {
		auto diff=diffs[i];
		if(diff.fPropertyRef.fObject == noteState) processMIDIEvent(diff);
		else {
			switch(diff.fPropertyTag) {
			case kJBox_EnvironmentSystemSampleRate:
				sampleRate = toFloat(diff.fCurrentValue);
				notes.setSampleRate(sampleRate);
				break;
			case kJBox_EnvironmentMasterTune:
				masterTune  = toFloat(diff.fCurrentValue)/100.0;
				notes.setMasterTune(masterTune);
				break;
			case kJBox_TransportRequestResetAudio:
				trace("Reset request");
				channel.reset();
				notes.reset();
				break;
			case Tags::ALPHA:
				trace("ALPHA is ^0",toFloat(diff.fCurrentValue));
				channel.setAlpha(toFloat(diff.fCurrentValue));
				break;
			case Tags::RELOAD:
				if(toBool(diff.fCurrentValue)) {
					trace("RELOAD");
					channel.reset();
				}
				break;
			case Tags::GAIN: {
				auto gain = toFloat(diff.fCurrentValue);
				trace("GAIN is ^0",gain);
				//left.setPan(sqrt(1-pan));
				//right.setPan(sqrt(pan));
				break; }
			case Tags::EXPONENT:
				trace("EXPONENT is ^0",toFloat(diff.fCurrentValue));
				channel.setExponent(toFloat(diff.fCurrentValue));
				break;
			default:
				break;
			}
		}
	}
	process();
}

}


