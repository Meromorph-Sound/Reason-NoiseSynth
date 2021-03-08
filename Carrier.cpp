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

	auto last=phase;
	phase = remainder(phase+delta+modDelta,meromorph::TwoPi);
	return (last>phase) ? 1.0 : 0.0;
}

int32 Pulse::multiStep(const uint32 n) {
	int32 offset=0;
	while(offset<n) {
		if(next()) return offset;
		offset++;
	}
	return -1;
}

void Pulse::setModulateActive(const bool m) {
	modulate=m;
	modDelta = modulate ? modulation : 0.f;
}
void Pulse::setModulation(const float32 m) {
	modulation=m;
	modDelta = modulate ? modulation : 0.f;
}



} /* namespace click */
} /* namespace meromorph */
