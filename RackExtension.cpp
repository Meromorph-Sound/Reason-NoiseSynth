#include <cmath>
#include <cstring>
#include "RackExtension.hpp"
#include <algorithm>

namespace meromorph {


const uint32 RackExtension::MAX_NOTES = 8;

TJBox_ObjectRef getRef(const char *base,const char *code) {
	char inP[80];
	append(inP,base,code);
	trace(inP);
	return JBox_GetMotherboardObjectRef(inP);
}

OutputChannel::OutputChannel(const char *code) : buffer(ChannelProcessor::BUFFER_SIZE) {
	output=getRef("/audio_outputs/audio",code);
}

void OutputChannel::write(iterator begin,iterator end) {
	auto p = pan;
	std::transform(begin,end,buffer.begin(),[p](float32 f) { return f*p; });

	auto ref = JBox_LoadMOMPropertyByTag(output, kJBox_AudioOutputBuffer);
	JBox_SetDSPBufferData(ref, 0, buffer.size(), buffer.data());
}



RackExtension::RackExtension() : notes(MAX_NOTES), left("L"), right("R") {
	noteState = JBox_GetMotherboardObjectRef("/note_states");
}

void RackExtension::process() {
	channel.process(currentNote);
	left.write(channel.begin(),channel.end());
	right.write(channel.begin(),channel.end());
}



void RackExtension::processMIDIEvent(const TJBox_PropertyDiff &diff) {
	auto event = JBox_AsNoteEvent(diff);
	if(forwarding) JBox_OutputNoteEvent(event); // forwarding notes
	if(notes.update(event)) {
		//trace("Upating note");
		if(notes.isOn()) currentNote=notes();
		else currentNote.setOff();
		//trace("Current note is ^0 and active ^1",currentNote.note, currentNote.isOn() ? 1 : 0);
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
			default:
				break;
			}
		}
	}
	process();
}

}


