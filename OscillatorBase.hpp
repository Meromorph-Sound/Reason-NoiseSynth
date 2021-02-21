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
	bool holding = false;

	void update();

public:
	OscillatorBase(const float32 N) : sampleRate(N) {};
	virtual ~OscillatorBase() = default;
	OscillatorBase(const OscillatorBase &other) = default;
	OscillatorBase& operator=(const OscillatorBase &other) = default;

	void setSampleRate(const float32 rate);
	void setFrequency(const float32 freq);
	virtual void hold(const bool h);
	virtual void reset();

	virtual float32 next() { return 0; }
};

class EdgeDetector {
private:
	float32 threshold = 0.5;
	uint32 delay = 0;
	float32 last = NAN;
	int32 counter = 0;


	bool trigger(const float32 value);

public:
	EdgeDetector() = default;
	EdgeDetector(const float32 t, const uint32 d=0) : threshold(t), delay(d) {}
	virtual ~EdgeDetector() = default;
	EdgeDetector(const EdgeDetector &) = default;
	EdgeDetector & operator=(const EdgeDetector &) = default;

	void reset();
	void setThreshold(const float32 t) { threshold=t; }
	void setDelay(const uint32 d = 0) { delay = d; }
	bool operator()(const float32 next);
};



} /* namespace click */
} /* namespace meromorph */

#endif /* OSCILLATORBASE_HPP_ */
