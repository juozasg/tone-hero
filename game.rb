#!/usr/bin/env ruby
# frozen_string_literal: true

require 'unimidi'
require 'midi-message'

# input = UniMIDI::Input.gets
input = UniMIDI::Input.open(0)

# c3 = 48 = MIDIMessage::Constant.value('Note', 'C3')
# name = 'C3' = MIDIMessage::Constant::Group['Note'].constants.find { |x| x.value == 48 }.key


NoteOn = 0x90
NoteOff = 0x91

pp NoteOn
pp NoteOff


puts "Reading MIDI from #{input.name} (#{input.id})"
100100.times do
	m = input.gets

	msg, note, vel = m[0][:data]

	if(msg == NoteOn) then
		puts "NoteOn: #{note} #{vel}"
	end

end
