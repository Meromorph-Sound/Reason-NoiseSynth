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
		PAN=3
	};


class OutputChannel {
private:
	TJBox_ObjectRef output;
	std::vector<float32> buffer;
	float32 pan=0;
public:
	using iterator=std::vector<float32>::iterator;
	OutputChannel(const char *code);
	virtual ~OutputChannel() = default;

	void write(iterator begin,iterator end);
	void setPan(const float32 p) { pan=p; }
};

class RackExtension {

	
private:
	const static uint32 MAX_NOTES;

	TJBox_ObjectRef noteState;

	NoteHandler notes;
	uint32 noteCount=0;

	bool forwarding = false;
	float32 masterTune = 1.0;
	float32 sampleRate = 48000;
	float32 pan=0;


	NoteEvent currentNote;
	ChannelProcessor channel;
	OutputChannel left,right;


	void process();


	void processMIDIEvent(const TJBox_PropertyDiff &diff);

public:
	static const uint32 BUFFER_SIZE;
	explicit RackExtension();
//	~CFollower(); 
    
    void RenderBatch(const TJBox_PropertyDiff iPropertyDiffs[], TJBox_UInt32 iDiffCount);

};
}
