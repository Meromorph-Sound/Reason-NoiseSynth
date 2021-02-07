/*
 * Carrier.cpp
 *
 *  Created on: 6 Feb 2021
 *      Author: julianporter
 */

#include "Carrier.hpp"

namespace meromorph {
namespace click {

const float32 Oscillator::TwoPi = 2*M_PI;

void Oscillator::update() {
	delta = Oscillator::TwoPi*frequency/sampleRate;
}

void Oscillator::setSampleRate(const float32 rate) {
	sampleRate=rate;
	update();
}
void Oscillator::setFrequency(const float32 freq) {
	frequency=freq;
	update();
}

void Oscillator::reset() {
	phase=0;
}

float32 Oscillator::next() {
	phase=remainder(phase+delta,Oscillator::TwoPi);
	return sin(phase);
}

} /* namespace click */
} /* namespace meromorph */
