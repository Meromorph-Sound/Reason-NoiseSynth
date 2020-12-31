/*
 * ChannelProcessor.hpp
 *
 *  Created on: 26 Dec 2020
 *      Author: julianporter
 */

#ifndef CHANNELPROCESSOR_HPP_
#define CHANNELPROCESSOR_HPP_

#include "base.hpp"
#include "notes.hpp"
#include "Random.hpp"

namespace meromorph {



class ChannelProcessor {
private:
	static const uint32 SEQUENCE_SIZE;
	Random rng;
	TJBox_ObjectRef env;
	std::vector<float32> buffer;

	float32 startPos=0;
	uint32 sequencePos = 0;

	bool isOn = false;
	uint32 note = 0;
	uint32 length = 1;
	float32 inc=0;
	float32 alpha=0;
	float32 exponent = 0.5;
	uint32 seed = 12;

	bool initialised=false;
	std::vector<float32> sequence;

	float32 getEnvVariable(const uint32 tag) const;


public:
	const static uint32 BUFFER_SIZE;
	using iterator=std::vector<float32>::iterator;
	using const_iterator=std::vector<float32>::const_iterator;

	ChannelProcessor();

	void process(const NoteEvent &note);
	void reset();
	void setAlpha(const float32 a) { alpha = a*0.5f; }
	void setExponent(const float32 e) { exponent = e; }
	void setSeed(const uint32 s) { seed = s; }

	iterator begin() { return buffer.begin(); }
	iterator end() { return buffer.end(); }
	const_iterator cbegin() const { return buffer.cbegin(); }
	const_iterator cend() const { return buffer.cend(); }



};

} /* namespace meromorph */

#endif /* CHANNELPROCESSOR_HPP_ */
