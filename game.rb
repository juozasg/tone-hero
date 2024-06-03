#!/usr/bin/env ruby
# frozen_string_literal: true

libdir = File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'ruby2d'
require 'tone-hero/midi'


input = open_midi_in
puts "Reading MIDI from #{input.name} (#{input.id})"
loop do
	m = input.gets

	msg, note, _ = m[0][:data]

	if(msg == NoteOn) then
		puts "NoteOn: #{note_name(note)}"
	end

end
