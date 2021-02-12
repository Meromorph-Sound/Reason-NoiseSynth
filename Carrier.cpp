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
	phase = remainder(phase+delta,meromorph::TwoPi);
	return (phase<delta) ? 1.0 : 0.0;
}

} /* namespace click */
} /* namespace meromorph */
