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
#import "Click.hpp"


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
	bool isTriggered() const { return triggered; }
	void setDelay(const float32 sampleRate,const float32 BUFFER_SIZE);
	Action step();
	void reset();
};

class Clicker : public RackExtension {
private:
	TJBox_ObjectRef left;
	TJBox_ObjectRef right;
	TJBox_ObjectRef externalTrigger;

	std::vector<float32> lBuffer;
	std::vector<float32> rBuffer;
	float32 lPan = 0.71;
	float32 rPan = 0.71;


	TriggerState tState;
	bool initialised = false;

	float32 sampleRate = 48000;
	bool clicking = false;
	uint32 clickOffset = 0;
	uint32 clickLength = 200;


	Carrier carrier;
	Clicks clicks;
	ClickShape click = ClickShape::SQUARE;

	float32 amplitude = 1.0;


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
