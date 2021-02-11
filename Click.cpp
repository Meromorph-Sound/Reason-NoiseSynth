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



const uint32 Clicks::CLICK_LENGTH = 200;
const uint32 Clicks::N_SHAPE_FUNCTIONS = 9;

ClickShape Clicks::asShape(const TJBox_PropertyDiff & diff) {
	int32 i = toInt(diff.fCurrentValue);
	int32 limited = clamp(0,(int32)N_SHAPE_FUNCTIONS-1,i);
	return static_cast<ClickShape>(limited);
}

Clicks::Clicks() {
	shapes=new float32[N_SHAPE_FUNCTIONS*CLICK_LENGTH];

	for(auto n=0;n<Clicks::CLICK_LENGTH;n++) {
		at(SQUARE,n) = 1;
		at(TRIANGULAR,n) = 1.0-(abs(n-100.0)/100.0);
		at(HALF_TRIANGULAR_DOWN,n) = std::max(0.0,1-(n/100.0));
		at(HALF_TRIANGULAR_UP,n) = (n<100) ? n/100.0 : 0.0;
		at(NORMAL,n) = exp(-pow((n-100.0)/10.0,2.0));
		at(POISSON,n) = exp(-n/10.0);
		at(DELTA,n) = (n<10) ? 1.0 : 0.0;
		at(EXP_FALL_HARD,n) = (n<100) ? 1.0-exp(n-75.0) : 0.0;
		at(EXP_FALL_SOFT,n) = (n<100) ? 1.0-exp(n-200.0) : 0.0;
	}
}

Clicks::~Clicks() {
	if(shapes!=nullptr) delete [] shapes;
}

uint32 Clicks::offsetFor(const ClickShape shape,const uint32 idx) {
	return idx+static_cast<uint32>(shape)*CLICK_LENGTH;
}

float32 &Clicks::at(const ClickShape click,const uint32 idx) { return shapes[offsetFor(click,idx)]; }
Clicks::iterator Clicks::begin(const ClickShape click) { return shapes+offsetFor(click); }
Clicks::iterator Clicks::end(const ClickShape click) { return shapes+offsetFor(click,CLICK_LENGTH); }
uint32 Clicks::size() const { return Clicks::CLICK_LENGTH; }


	// TODO Auto-generated constructor stub




} /* namespace click */
} /* namespace meromorph */
