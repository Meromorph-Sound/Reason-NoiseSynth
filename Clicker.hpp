/*
 * Clicker.hpp
 *
 *  Created on: 31 Jan 2021
 *      Author: julianporter
 */

#ifndef CLICKER_HPP_
#define CLICKER_HPP_

#import "RackExtension.hpp"
#import "Carrier.hpp"


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



struct TriggerState {
	static const float32 TriggerPeriod;
	enum Action : uint32 {
		SET = 1,
		RESET = 2,
		NIL = 3
	};
	uint32 triggerDelay = 1;
	int32 triggeredCount = 0;
	bool triggered = false;

	TriggerState() = default;
	virtual ~TriggerState() = default;

	void set() { triggered=true; }
	void clear() { triggered=false; }
	void setDelay(const float32 sampleRate,const float32 BUFFER_SIZE);
	Action step();
	void reset();
};

class Clicker : public RackExtension {
private:
	TJBox_ObjectRef left;
	TJBox_ObjectRef right;
	TJBox_ObjectRef externalTrigger;


	TriggerState tState;
	bool initialised = false;

	float32 sampleRate = 48000;


	Carrier carrier;

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
