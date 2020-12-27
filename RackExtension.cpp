#include <cmath>
#include <cstring>
#include "RackExtension.hpp"

namespace meromorph {

const uint32 RackExtension::MAX_NOTES = 64;


RackExtension::RackExtension() : notes(MAX_NOTES), left("L"), right("R") {
	noteState = JBox_GetMotherboardObjectRef("/note_states");
}

void RackExtension::process() {

		left.process(currentNote);
		right.process(currentNote);

}



void RackExtension::processMIDIEvent(const TJBox_PropertyDiff &diff) {
	auto event = JBox_AsNoteEvent(diff);
	if(forwarding) JBox_OutputNoteEvent(event); // forwarding notes
	auto note=NoteEvent(event,masterTune,sampleRate);

	if(currentNote.isOff()) {
		if(note.isOn()) currentNote=note;
	}
	else {
		if(note.isOff() && note.note==currentNote.note) currentNote.setOff();
		else if(note.isOn() && note.note!=currentNote.note) currentNote=note;
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
				break;
			case kJBox_EnvironmentMasterTune:
				masterTune  = toFloat(diff.fCurrentValue)/100.0;
				break;
			case kJBox_TransportRequestResetAudio:
				trace("Reset request");
				left.reset();
				right.reset();
				break;
			default:
				break;
			}
		}
	}
	process();
}

}


