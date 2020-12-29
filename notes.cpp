/*
 * notes.cpp
 *
 *  Created on: 28 Dec 2020
 *      Author: julianporter
 */

#include "notes.hpp"

namespace meromorph {

NoteEvent::NoteEvent() : note(0), velocity(0), index(0),
		masterTune(1), sampleRate(48000), action(Invalid), id(0) {}

void NoteEvent::load (const uint8 note_,const uint8 velocity_,const uint16 idx_,
		const uint64 id_,const float32 masterTune_,const float32 rate) {
	note=note_;
		velocity=velocity_;
		index=idx_;
		masterTune=masterTune_;
		sampleRate=rate;
		action = velocity>0 ? NoteOn : NoteOff;
		id=id_;
}

void NoteEvent::load(const TJBox_NoteEvent &event,const uint64 id_,const float32 masterTune_,const float32 rate) {
	load(event.fNoteNumber,event.fVelocity,event.fAtFrameIndex,id_,masterTune_,rate);
}

bool NoteEvent::match(const uint8 note_) const {
	return isValid() && note==note_;
}
bool NoteEvent::precedes(const NoteEvent &other) const { return id<other.id; }



float32 NoteEvent::frequency() const {
	return std::powf(2.0f, ((note + masterTune) - 69.0f) / 12.0f) * 440.0f;
}
uint32 NoteEvent::period() const {
	auto f = frequency();
	if(f<=0) return 0;
	else {
		auto p = lround(sampleRate/f);
		return (uint32)p;
	}
}

void NoteHandler::reset() {
	std::for_each(notes.begin(),notes.end(),[](auto &n) { n.invalidate();});
	currentIndex=notes.end();
}


NoteHandler::iterator NoteHandler::activeAt(const uint8 note_)  {
	return std::find_if(notes.begin(),notes.end(),
			[note_](NoteEvent & event) { return event.isOn() && event.note==note_; });
}

NoteHandler::iterator NoteHandler::waitingAt(const uint8 note_)  {
	return std::find_if(notes.begin(),notes.end(),
			[note_](NoteEvent & event) { return event.isOff() && event.note==note_; });
}

bool NoteHandler::noValidNote(const uint8 note_)  {
	auto it = std::find_if(notes.begin(),notes.end(),
			[note_](NoteEvent & event) { return event.isValid() && event.note==note_; });
	return it==notes.end();
}

void NoteHandler::load(const TJBox_NoteEvent &event) {
	if(currentIndex!=notes.end()) currentIndex->load(event,++id,masterTune,sampleRate);
}

bool NoteHandler::update(const TJBox_NoteEvent &event) {
	bool isOn = event.fVelocity>0;
	auto note = event.fNoteNumber;


	/// trying to switch the note on: this can only happen if there is currently
	/// no valid (on or waiting) matching note

	if(isOn && noValidNote(note)) {
		//trace("Switching on new note ^0",note);
		///  if there is an active note, switch it to wait mode
		if(currentIndex!=notes.end()) currentIndex->setOff();

		/// now find a slot (preferably invalid)
		auto it=std::find_if(notes.begin(),notes.end(),
				[](NoteEvent & n) { return n.isInvalid(); });
		if(it!=notes.end()) {
			/// found one
			currentIndex=it;
		}
		else {
			/// going to have to steal one of the waiting notes :
			/// go for the oldest
			auto itm = std::min_element(notes.begin(),notes.end(),
					[](NoteEvent &n1,NoteEvent &n2) { return n1.id < n2.id; });
			if(itm!=notes.end()) {
				/// found one to steal
				currentIndex=itm;
			}
			else {
				/// strange stuff is happening
				currentIndex=notes.begin();
			}
		}
		load(event);
		return true;
	}

	else if(!isOn) {
		//trace("Switching off note ^0",note);
		/// it wants to switch off the active note
		auto it=activeAt(note);
		if(it!=notes.end()) {
			//trace("It's the active note - switching it off");
			it->invalidate();

			/// now find the most recent valid note
			auto it = notes.begin(); // get pointer to element with highest id that's not on
			//trace("First note has id ^0", it->id);
			for(auto it2=notes.begin()+1;it2!=notes.end();it2++) {
				if(it2->isValid() && (it->id)<(it2->id)) it=it2;
				//trace("Next note has id ^0 and is valid ^1", it2->id,it2->isValid() ? 1 : 0);
			}
			//trace("Picked note has id ^0 and is valid ^1", it->id,it->isValid() ? 1 : 0);

			/// check again
			if(it->isValid()) {
				//trace("Switching it on");
				it->setOn();
				currentIndex=it;
			}
			else {
				//trace("Nothing to switch on");
				currentIndex=notes.end();
			}
			return true;
		}
		else {
			//trace("It's an inactive note - switching it off");
			/// no active note; check if there is a waiting one
			auto itt = waitingAt(note);
			if(itt!=notes.end()) {
				//trace("Found note at ^0 - invalidating",itt-notes.begin());
				/// there is a waiting note; invalidate it, but no more change
				itt->invalidate();
			}
			return false;
		}
	}
	else return false;
}


} /* namespace meromorph */
