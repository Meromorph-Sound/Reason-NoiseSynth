/*
 * Carrier.hpp
 *
 *  Created on: 6 Feb 2021
 *      Author: julianporter
 */

#ifndef CARRIER_HPP_
#define CARRIER_HPP_

#include "base.hpp"
#include "OscillatorBase.hpp"

namespace meromorph {
namespace click {

#define PER_SAMPLE

class Carrier : public OscillatorBase {
protected:

public:
	Carrier() : OscillatorBase(48000) {};
	virtual ~Carrier() = default;
	Carrier(const Carrier &other) = default;
	Carrier& operator=(const Carrier &other) = default;

	virtual float32 next();

};

class Pulse : public OscillatorBase {
protected:
	bool modulate = false;
	float32 modulation = 0;
	float32 modDelta=0;
public:
	Pulse() : OscillatorBase(48000) {};
	//Pulse() : OscillatorBase(750) {};
	virtual ~Pulse() = default;
	Pulse(const Pulse &other) = default;
	Pulse& operator=(const Pulse &other) = default;

	virtual float32 next();
	int32 multiStep(const uint32);
	void setModulateActive(const bool);
	void setModulation(const float32);
};




} /* namespace click */
} /* namespace meromorph */

#endif /* CARRIER_HPP_ */
