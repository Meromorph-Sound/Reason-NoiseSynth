/*
 * Property.cpp
 *
 *  Created on: 28 Feb 2021
 *      Author: julianporter
 */

#include "Property.hpp"

namespace meromorph {
namespace click {

float32 Property::pitch(const TJBox_PropertyDiff &diff) {
	//return scaledFloat(diff.fCurrentValue,PITCH_MIN,PITCH_MAX);
	return toInt(diff.fCurrentValue);
}

uint32 Property::length(const TJBox_PropertyDiff &diff) {
	return 1+toInt(diff.fCurrentValue);
}

Pan Property::pan(const TJBox_PropertyDiff &diff) {
	return Pan(scaledFloat(diff.fCurrentValue,0,meromorph::Pi/2));
}

TriggerMode Property::triggerMode(const TJBox_PropertyDiff & diff) {
	int32 i = toInt(diff.fCurrentValue);
	int32 limited = clamp(0,2,i);
	return static_cast<TriggerMode>(limited);
}


float32 Property::limit(const TJBox_PropertyDiff &diff) {
	auto l = scaledFloat(diff.fCurrentValue,-12.f,0.f);
	return pow(10.f,l*0.1f);
}

Limiter::Mode Property::limitMode(const TJBox_PropertyDiff &diff) {
	return toBool(diff.fCurrentValue) ? Limiter::HARD : Limiter::SOFT;
}

float32 Property::lfoFreq(const TJBox_PropertyDiff &diff) {
	return toInt(diff.fCurrentValue)*0.1f;
	//return toFloat(diff.fCurrentValue)/10.0f;
	//return scaledFloat(diff.fCurrentValue,LFO_MIN,LFO_MAX);
}

uint32 Property::triggerDebounce(const TJBox_PropertyDiff &diff) {
	return lround(scaledFloat(diff.fCurrentValue,DEBOUNCE_MIN,DEBOUNCE_MAX));
}

float32 Property::triggerThreshold(const TJBox_PropertyDiff &diff) {
	return clampedFloat(diff.fCurrentValue);
}

} /* namespace click */
} /* namespace meromorph */
