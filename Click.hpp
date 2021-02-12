/*
 * Click.hpp
 *
 *  Created on: 3 Feb 2021
 *      Author: julianporter
 */

#ifndef CLICK_HPP_
#define CLICK_HPP_

#include "base.hpp"
#include <algorithm>
#include <cmath>
#include <map>
#include <functional>

namespace meromorph {
namespace click {



enum ClickShape : uint32 {
	NORMAL = 0,
	POISSON = 1,
	HALF_TRIANGULAR_DOWN = 2,
	HALF_TRIANGULAR_UP = 3,
	TRIANGULAR = 4,
	DELTA = 5,
	EXP_FALL_HARD = 6,
	EXP_FALL_SOFT = 7,
	SQUARE = 8,


};



class Clicks {
protected:
	static const uint32 CLICK_LENGTH;
	static const uint32 N_SHAPE_FUNCTIONS;

	float32 *shapes;

	uint32 offsetFor(const ClickShape shape,const uint32 idx=0);
	float32 scale = 1.0;

public:
	using iterator = float32 *;
	ClickShape static asShape(const TJBox_PropertyDiff&);

	Clicks();
	virtual ~Clicks();
	Clicks(const Clicks &other) = default;
	Clicks& operator=(const Clicks &other) = default;


	float32 &at(const ClickShape click,const uint32 idx);
	iterator begin(const ClickShape click);
	iterator end(const ClickShape click);
	uint32 size() const;

	void setScale(const uint32 length);

};

} /* namespace click */
} /* namespace meromorph */

#endif /* CLICK_HPP_ */
