/*
 * OscillatorBase.cpp
 *
 *  Created on: 12 Feb 2021
 *      Author: julianporter
 */

#include "OscillatorBase.hpp"

namespace meromorph {
namespace click {

void OscillatorBase::update() {
	delta = meromorph::TwoPi*frequency/sampleRate;
}

void OscillatorBase::setSampleRate(const float32 rate) {
	sampleRate=rate;
	update();
}
void OscillatorBase::setFrequency(const float32 freq) {
	frequency=freq;
	update();
}

void OscillatorBase::reset() {
	phase=0;
}





} /* namespace click */
} /* namespace meromorph */
