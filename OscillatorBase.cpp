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
void OscillatorBase::hold(const bool h) {
	holding=h;
}



void EdgeDetector::reset() {
	last=NAN;
	counter=0;
}

	bool EdgeDetector::operator()(const float32 next) {
		bool out=false;
		if(counter>0) counter--;
		else if(last<threshold && next>threshold) {
			counter=delay;
			out=true;
		}
		last=next;
		return out;
	}


} /* namespace click */
} /* namespace meromorph */
