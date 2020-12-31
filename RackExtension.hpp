#pragma once

#include "base.hpp"
#include "ChannelProcessor.hpp"
#include "notes.hpp"
#include <vector>
#include <cmath>

namespace meromorph {

enum Tags : uint32 {
		ALPHA=1,
		RELOAD=2,
		SEED=3,
		EXPONENT=4,
		NOTE = 5,
		VOLUME = 6,
		PITCH_BEND_RANGE = 9,
		PITCH_BEND = 10,
		EXPRESSION = 11
	};


class RackExtension {

	
private:
	const static uint32 MAX_NOTES;

	TJBox_ObjectRef noteState;
	TJBox_ObjectRef left;
	TJBox_ObjectRef right;
	TJBox_ObjectRef props;

	NoteHandler notes;
	uint32 noteCount=0;

	bool forwarding = false;
	float32 masterTune = 1.0;
	float32 sampleRate = 48000;
	std::vector<float32> buffer;
	float32 lastNorm=0.0f;



	NoteEvent currentNote;
	ChannelProcessor channel;

	void set(const float32 value,const Tag tag);
	void process();


	void processMIDIEvent(const TJBox_PropertyDiff &diff);

public:
	static const uint32 BUFFER_SIZE;
	explicit RackExtension();
//	~CFollower(); 
    
    void RenderBatch(const TJBox_PropertyDiff iPropertyDiffs[], TJBox_UInt32 iDiffCount);

};
}
