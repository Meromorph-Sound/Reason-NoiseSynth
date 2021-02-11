/*
 * Carrier.hpp
 *
 *  Created on: 6 Feb 2021
 *      Author: julianporter
 */

#ifndef CARRIER_HPP_
#define CARRIER_HPP_

#include "base.hpp"

namespace meromorph {
namespace click {

class Oscillator {
protected:
	float32 sampleRate;
	float32 frequency = 0;
	float32 phase =0;
	float32 delta =0;

	void update();
public:
	Oscillator(const float32 N) : sampleRate(N) {};
	virtual ~Oscillator() = default;
	Oscillator(const Oscillator &other) = default;
	Oscillator& operator=(const Oscillator &other) = default;

	void setSampleRate(const float32 rate);
	void setFrequency(const float32 freq);
	virtual void reset();

	virtual float32 next();

};

class Carrier : public Oscillator {

public:
	Carrier() : Oscillator(48000) {};
	virtual ~Carrier() = default;
	Carrier(const Carrier &other) = default;
	Carrier& operator=(const Carrier &other) = default;

};

} /* namespace click */
} /* namespace meromorph */

#endif /* CARRIER_HPP_ */
