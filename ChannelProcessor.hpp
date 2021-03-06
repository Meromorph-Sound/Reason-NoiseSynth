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
	Bernoulli flag;
	TJBox_ObjectRef env;
	std::vector<float32> buffer;

	float32 startPos=0;
	uint32 sequencePos = 0;

	bool isOn = false;
	float32 note = 0;
	uint32 length = 1;
	float32 inc=0;
	float32 alpha=0;
	float32 exponent = 0.5;
	uint64 seed = 0x1956183;
	float32 permutationSize = 25.0;


	bool initialised=false;
	std::vector<float32> sequence;

	float32 getEnvVariable(const uint32 tag) const;
	void permute(const uint32 offset);


public:
	const static uint32 BUFFER_SIZE;
	using iterator=std::vector<float32>::iterator;
	using const_iterator=std::vector<float32>::const_iterator;

	ChannelProcessor();

	void process(const NoteEvent &note);
	void reset();
	void setAlpha(const float32 a) { alpha = a*0.5f; }
	void setExponent(const float32 e) { exponent = e; }
	void setSeed(const uint64 s) { seed = s; }
	void setMutationRate(const float32 m) { flag.setThreshold(m); }
	void setMutationRange(const float32 r) { permutationSize=r; }

	iterator begin() { return buffer.begin(); }
	iterator end() { return buffer.end(); }
	const_iterator cbegin() const { return buffer.cbegin(); }
	const_iterator cend() const { return buffer.cend(); }



};

} /* namespace meromorph */

#endif /* CHANNELPROCESSOR_HPP_ */
