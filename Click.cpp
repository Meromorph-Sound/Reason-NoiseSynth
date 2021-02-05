/*
 * Click.cpp
 *
 *  Created on: 3 Feb 2021
 *      Author: julianporter
 */

#include "Click.hpp"
#include <functional>
#include <utility>

namespace meromorph {
namespace click {



const uint32 Shape::CLICK_LENGTH = 200;
Shape & Shape::operator=(const Shape &o) {
		std::copy(o.buffer.begin(),o.buffer.end(),buffer.begin());
		return *this;
	}
float32 Shape::operator[](const uint32 n) const { return (n<CLICK_LENGTH) ? buffer[n] : 0.0; }
void Shape::load(ShapeFunction &&func) {
	for(auto i=0;i<CLICK_LENGTH;i++) buffer[i]=func(i);
}

Clicks::Clicks()  {
	clicks[SQUARE].load([](const uint32 f) { return (float32)f; });
	clicks[TRIANGULAR].load([](const uint32 n) { return 1.0-(abs(n-100.0)/100.0); });
	clicks[HALF_TRIANGULAR_DOWN].load([](const uint32 n) { return std::max(0.0,1-(n/100.0)); });
	clicks[HALF_TRIANGULAR_UP].load([](const uint32 n) { return (n<100) ? n/100.0 : 0.0; });
	clicks[NORMAL].load([](const uint32 n) { return exp(-pow((n-100.0)/10.0,2.0)); });
	clicks[POISSON].load([](const uint32 n) { return exp(-n/10.0); });
	clicks[DELTA].load([](const uint32 n) { return (n<10) ? 1.0 : 0.0; });
	clicks[EXP_FALL_HARD].load([](const uint32 n){ return (n<100) ? 1.0-exp(n-75.0) : 0.0; });
	clicks[EXP_FALL_SOFT].load([](const uint32 n){ return (n<100) ? 1.0-exp(n-200.0) : 0.0; });
}


	// TODO Auto-generated constructor stub




} /* namespace click */
} /* namespace meromorph */
