/*
 * Carrier.cpp
 *
 *  Created on: 6 Feb 2021
 *      Author: julianporter
 */

#include "Carrier.hpp"

namespace meromorph {
namespace click {

float32 Carrier::next() {
	phase=remainder(phase+delta,meromorph::TwoPi);
	return sin(phase);
}

float32 Pulse::next() {
	if(holding) return 0.0;

	auto mod = modulate ? modulation : 0.f;
	auto last=phase;
	phase = remainder(phase+delta+mod,meromorph::TwoPi);
	return (last>phase) ? 1.0 : 0.0;
}

void Pulse::setModulateActive(const bool m) {
	modulate=m;
}
void Pulse::setModulation(const float32 m) {
	modulation=m;
}



} /* namespace click */
} /* namespace meromorph */
