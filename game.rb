#!/usr/bin/env ruby
# frozen_string_literal: true

libdir = File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'tone-hero/midi'
require 'tone-hero/mainloop'


input = open_midi_in
puts "Reading MIDI from #{input.name} (#{input.id})"

mainloop = ToneHero::MainLoop.new(input)
mainloop.run
