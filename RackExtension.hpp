#pragma once

#include "base.hpp"
#include "ChannelProcessor.hpp"
#include <vector>
#include <cmath>

namespace meromorph {

enum Tags : uint32 {
		LR=1,
		TH=2,
		BUTTON=3,
		MODE=4,
		GATE=5
	};



class RackExtension {

	
private:
	const static uint32 MAX_NOTES;

	TJBox_ObjectRef noteState;

	std::vector<NoteEvent> notes;
	uint32 noteCount=0;

	bool forwarding = false;
	float32 masterTune = 1.0;
	float32 sampleRate = 48000;



	NoteEvent currentNote;
	ChannelProcessor left, right;



	void process();


	void processMIDIEvent(const TJBox_PropertyDiff &diff);

public:
	static const uint32 BUFFER_SIZE;
	explicit RackExtension();
//	~CFollower(); 
    
    void RenderBatch(const TJBox_PropertyDiff iPropertyDiffs[], TJBox_UInt32 iDiffCount);

};
}
