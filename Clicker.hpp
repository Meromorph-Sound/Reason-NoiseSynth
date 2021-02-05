/*
 * Clicker.hpp
 *
 *  Created on: 31 Jan 2021
 *      Author: julianporter
 */

#ifndef CLICKER_HPP_
#define CLICKER_HPP_

#import "RackExtension.hpp"


namespace meromorph {
namespace click {

enum Tags : uint32 {
	SHAPE=1,
	PITCH=2,
	LENGTH=3,
	PAN=4,
	AMPLITUDE=5,
	TRIGGER=6,
	TRIGGER_MODE=7,

	TRIGGER_BACK = 10
	};


class Clicker : public RackExtension {
private:
	TJBox_ObjectRef left;
	TJBox_ObjectRef right;
	TJBox_ObjectRef externalTrigger;

	static const float32 TriggerPeriod;
	uint32 triggerDelay = 1;
	int32 triggeredCount = 0;
	bool triggered = false;
	bool initialised = false;



	float32 sampleRate = 48000;



	void computeTriggerDelay();
	void handleTriggerLED();

protected:
	virtual void setSampleRate(const float32 rate);
	virtual void processApplicationMessage(const TJBox_PropertyDiff &diff);
	virtual void process();
	virtual void reset() {}
public:
	Clicker();
	virtual ~Clicker() = default;
	Clicker(const Clicker &other) = default;
	Clicker& operator=(const Clicker &other) = default;



};

} /* namespace click */
} /* namespace meromorph */

#endif /* CLICKER_HPP_ */
