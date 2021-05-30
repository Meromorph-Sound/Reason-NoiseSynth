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
		MUTATE = 7,
		MUTATE_RANGE = 8,
		PITCH_BEND_RANGE = 9,
		PITCH_BEND = 10,
		EXPRESSION = 11
	};


class RackExtension {

	
private:
	const static uint32 MAX_NOTES;
	const static float32 constexpr MutateRanges[] = {5,10,25,50,75,100};
	const static uint32 MAX_MUTATE_RANGES;
	const static Tag constexpr AllTags[] = { ALPHA,SEED,EXPONENT,MUTATE,MUTATE_RANGE,PITCH_BEND_RANGE };
	const static uint32 N_TAGS;
	TJBox_ObjectRef noteState;
	TJBox_ObjectRef left;
	TJBox_ObjectRef right;
	TJBox_ObjectRef props;

	NoteHandler notes;
	uint32 noteCount=0;

	bool forwarding = false;
	float32 masterTune = 1.0;
	float32 sampleRate = 48000;

	uint32 pitchBendRange = 12;
	float32 pitchBend = 0;
	float32 expression = 0.0;


	std::vector<float32> buffer;

	bool loaded = false;


	NoteEvent currentNote;
	ChannelProcessor channel;

	void set(const float32 value,const Tag tag);
	float32 get(const Tag tag);
	uint8 getSecret(const Tag tag);
	void reload();
	void process();


	void processMIDIEvent(const TJBox_PropertyDiff &diff);

protected:
	virtual uint64 generateSeed();

public:
	static const uint32 BUFFER_SIZE;
	explicit RackExtension();
//	~CFollower(); 
    
    void RenderBatch(const TJBox_PropertyDiff iPropertyDiffs[], TJBox_UInt32 iDiffCount);

};
}
