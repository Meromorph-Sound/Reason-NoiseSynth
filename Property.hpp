/*
 * Property.hpp
 *
 *  Created on: 28 Feb 2021
 *      Author: julianporter
 */

#ifndef PROPERTY_HPP_
#define PROPERTY_HPP_

#include "base.hpp"
#include "Limiter.hpp"


namespace meromorph {
namespace click {

class Pan {
private:
	float32 left;
	float32 right;

public:

	Pan(const float32 angle=meromorph::Pi/4) {
		left=cos(angle);
		right=sin(angle);
	}
	Pan(const Pan &) = default;
	Pan & operator=(const Pan &) = default;
	~Pan() = default;

	float32 toLeft(const float32 s) const { return s*left; }
	float32 toRight(const float32 s) const { return s*right; }
};

class Property {
public:

	const static inline float32 PITCH_MIN = 20.f;
	const static inline float32 PITCH_MAX = 10000.f;

	const static inline float32 LENGTH_MIN = 1.f;
	const static inline float32 LENGTH_MAX = 500.f;

	const static inline float32 LFO_MIN = 0.f;
	const static inline float32 LFO_MAX = 750.f;

	const static inline float32 DEBOUNCE_MIN = 0;
	const static inline float32 DEBOUNCE_MAX = 63;

	static float32 pitch(const TJBox_PropertyDiff &);
	static uint32 length(const TJBox_PropertyDiff &);
	static Pan pan(const TJBox_PropertyDiff &);

	static TriggerMode triggerMode(const TJBox_PropertyDiff &);

	static float32 limit(const TJBox_PropertyDiff &);
	static Limiter::Mode limitMode(const TJBox_PropertyDiff &);

	static float32 lfoFreq(const TJBox_PropertyDiff &);

	static float32 triggerThreshold(const TJBox_PropertyDiff &);
	static uint32 triggerDebounce(const TJBox_PropertyDiff &);
};

} /* namespace click */
} /* namespace meromorph */

#endif /* PROPERTY_HPP_ */
