/*
 * notes.hpp
 *
 *  Created on: 28 Dec 2020
 *      Author: julianporter
 */

#ifndef NOTES_HPP_
#define NOTES_HPP_

#include "base.hpp"
#include <vector>

namespace meromorph {

enum NoteActions {
	NoteOn,
	NoteOff,
	Invalid
};

struct NoteEvent {

	uint8 note;
	uint8 velocity;
	uint16 index;
	float32 masterTune;
	float32 sampleRate;
	NoteActions action;

	uint64 id;

	NoteEvent();
	NoteEvent(const NoteEvent &) = default;
	NoteEvent & operator=(const NoteEvent &) = default;

	float32 level() const;
	float32 frequency() const;
	uint32 period() const;
	bool isOn () const { return action==NoteActions::NoteOn; }
	bool isOff() const { return action==NoteActions::NoteOff; }
	void setOff() { action=NoteActions::NoteOff; }
	void setOn() { action=NoteActions::NoteOn; }
	void touch(const uint64 id_) { setOn(); id=id_; }
	bool isInvalid() const { return action==NoteActions::Invalid; }
	bool isValid() const { return action!=NoteActions::Invalid; }

	void load (const uint8 note_,const uint8 velocity_,const uint16 idx_,const uint64 id_=0,const float32 masterTune_=1.0f,const float32 rate=48000.0f);
	void load (const TJBox_NoteEvent &event,const uint64 id_,const float32 masterTune_=1.0f,const float32 rate=48000.0f);

	bool match(const uint8 note_) const;

	bool precedes(const NoteEvent &) const;

	void invalidate() { action=NoteActions::Invalid; }

};



class NoteHandler {
private:
	using iterator = std::vector<NoteEvent>::iterator;

	uint32 maxNotes;
	std::vector<NoteEvent> notes;
	uint64 id = 0;

	iterator currentIndex;

	float32 masterTune = 1.0f;
	float32 sampleRate = 48000.0f;

	iterator activeAt(const uint8 note_) ;
	iterator waitingAt(const uint8 note_) ;
	bool noValidNote(const uint8 note_) ;

	void load(const TJBox_NoteEvent &event);


public:
	NoteHandler(const uint32 maxNotes_) : maxNotes(maxNotes_), notes(maxNotes), currentIndex(notes.end()) {};
	virtual ~NoteHandler() = default;

	NoteEvent operator()() const { return *currentIndex; }
	bool isOn() const { return (currentIndex==notes.end()) ? false : currentIndex->isOn(); }

	void setMasterTune(const float32 tune) { masterTune=tune; }
	void setSampleRate(const float32 rate) { sampleRate=rate; }

	bool update(const TJBox_NoteEvent &event);

	void reset();
};


} /* namespace meromorph */

#endif /* NOTES_HPP_ */
