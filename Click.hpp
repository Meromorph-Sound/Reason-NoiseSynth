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

using ShapeFunction = std::function<float32(const uint32)>;

class Shape {
protected:
	std::vector<float32> buffer;
public:
	static const uint32 CLICK_LENGTH;
	using iterator = std::vector<float32>::iterator;
	using const_iterator = std::vector<float32>::const_iterator;
	using size_t = uint32;


	Shape() : buffer(CLICK_LENGTH) {};
	Shape(const Shape &o) : buffer(o.buffer) {};
	Shape & operator=(const Shape &o);
	virtual ~Shape() = default;

	void load(ShapeFunction &&func);
	float32 operator[](const uint32 n) const;

	size_t size() const { return buffer.size(); }
	iterator begin() { return buffer.begin(); }
	iterator end() { return buffer.end(); }
	const_iterator cbegin() const { return buffer.cbegin(); }
	const_iterator cend() const { return buffer.cend(); }

};

enum ClickShape : uint32 {
	SQUARE = 0,
	TRIANGULAR = 1,
	HALF_TRIANGULAR_DOWN = 2,
	HALF_TRIANGULAR_UP = 3,
	NORMAL = 4,
	POISSON = 5,
	DELTA = 6,
	EXP_FALL_HARD = 7,
	EXP_FALL_SOFT = 8,

	N_SHAPE_FUNCTIONS = 9
};



class Clicks {
protected:


	Shape clicks[N_SHAPE_FUNCTIONS];
public:
	Clicks();
	virtual ~Clicks() = default;
	Clicks(const Clicks &other) = default;
	Clicks& operator=(const Clicks &other) = default;

	float32 at(const ClickShape click,const uint32 idx) const { return clicks[click][idx]; }
	Shape::iterator begin(const ClickShape click) { return clicks[click].begin(); }
	Shape::iterator end(const ClickShape click) { return clicks[click].end(); }
	uint32 size() const { return Shape::CLICK_LENGTH; }

};

} /* namespace click */
} /* namespace meromorph */

#endif /* CLICK_HPP_ */
