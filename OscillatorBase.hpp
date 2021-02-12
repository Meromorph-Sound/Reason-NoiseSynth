/*
 * OscillatorBase.hpp
 *
 *  Created on: 12 Feb 2021
 *      Author: julianporter
 */

#ifndef OSCILLATORBASE_HPP_
#define OSCILLATORBASE_HPP_

#include "base.hpp"

namespace meromorph {
namespace click {

class OscillatorBase {
protected:
	float32 sampleRate;
	float32 frequency = 0;
	float32 phase =0;
	float32 delta =0;

	void update();

public:
	OscillatorBase(const float32 N) : sampleRate(N) {};
	virtual ~OscillatorBase() = default;
	OscillatorBase(const OscillatorBase &other) = default;
	OscillatorBase& operator=(const OscillatorBase &other) = default;

	void setSampleRate(const float32 rate);
	void setFrequency(const float32 freq);
	virtual void reset();

	virtual float32 next() { return 0; }
};

class Thresholder {
private:
	float32 threshold;
	bool last;

public:

	Thresholder() : threshold(0.5), last(false) {};
	Thresholder(const float32 t) : threshold(t), last(false) {};
	virtual ~Thresholder() = default;
	Thresholder(const Thresholder &) = default;
	Thresholder & operator=(const Thresholder &) = default;

	void reset() { last = false; }
	void setThreshold(const float32 t) { threshold=t; }

	bool operator()(const float32 value) {
		auto  t=value>threshold;
		auto out = t && (!last);
		last = t;
		return out;
	}
};

class HysteresisThresholder {
private:
	float32 threshold;
	uint32 gap;
	bool last;
	bool blocked;
	uint32 counter;

public:

	HysteresisThresholder() : threshold(0.5), last(false), gap(1), counter(0) {};
	HysteresisThresholder(const float32 t,const uint32 g=1) : threshold(t), last(false), gap(g), counter(0) {};
	virtual ~HysteresisThresholder() = default;
	HysteresisThresholder(const HysteresisThresholder &) = default;
	HysteresisThresholder & operator=(const HysteresisThresholder &) = default;

	void reset() { last = false; counter=0; }
	void setThreshold(const float32 t) { threshold=t; }
	void seGap(const uint32 g) { gap=g; }

	bool operator()(const float32 value) {
		auto  t=value>threshold;
		if(t && !last) {

		}
		auto out = t && (!last);
		last = t;
		return out;
	}
};

} /* namespace click */
} /* namespace meromorph */

#endif /* OSCILLATORBASE_HPP_ */
