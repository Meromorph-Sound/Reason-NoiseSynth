/*
 * ChannelProcessor.hpp
 *
 *  Created on: 26 Dec 2020
 *      Author: julianporter
 */

#ifndef CHANNELPROCESSOR_HPP_
#define CHANNELPROCESSOR_HPP_

#include "base.hpp"
#include "Random.hpp"

namespace meromorph {

enum NoteActions {
	NoteOn,
	NoteOff
};

struct NoteEvent {

	uint8 note;
	uint8 velocity;
	uint16 index;
	float32 masterTune;
	float32 sampleRate;
	NoteActions action;

	NoteEvent();
	NoteEvent(const TJBox_NoteEvent &event,const float32 masterTune_=1.0f,const float32 rate=48000.0f);
	NoteEvent(const NoteEvent &) = default;
	NoteEvent & operator=(const NoteEvent &) = default;

	float32 frequency() const;
	uint32 period() const;
	bool isOn () const { return action==NoteActions::NoteOn; }
	bool isOff() const { return action==NoteActions::NoteOff; }
	void setOff() { action=NoteActions::NoteOff; }
	void load(const TJBox_NoteEvent &event,const float32 masterTune_=1.0f,const float32 rate=48000.0f);
};

class ChannelProcessor {
private:
	static const uint32 SEQUENCE_SIZE;
	Random rng;
	TJBox_ObjectRef output;
	TJBox_ObjectRef env;
	float32 last = 0;
	std::vector<float32> buffer;

	uint32 sequencePos = 0;

	bool isOn = false;
	uint32 note = 0;
	uint32 length = 1;

	bool initialised=false;
	std::vector<float32> sequence;

	float32 getEnvVariable(const uint32 tag) const;

	uint32 read();
	void write();

public:
	const static uint32 BUFFER_SIZE;

	ChannelProcessor(const char *code);

	void process(const NoteEvent &note);
	void reset();




};

} /* namespace meromorph */

#endif /* CHANNELPROCESSOR_HPP_ */
