#!/usr/bin/env ruby
# frozen_string_literal: true
libdir = File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

# require 'tone-hero/midi'
# # require 'tone-hero/mainloop'
# #
# #
# listen_channel_midi do |byte1, byte2, byte3|
#   puts "#{byte1}, #{byte2}, #{byte3}"
# end

# loop do
#   puts ""
#   sleep 1
# end


require 'java'

_infos = javax.sound.midi.MidiSystem.get_midi_device_info
infos = []
_infos.each { |info| infos.push info if javax.sound.midi.MidiSystem.get_midi_device(info).class == Java::ComSunMediaSound::MidiInDevice}

infos.each do |info|
  device = javax.sound.midi.MidiSystem.get_midi_device(info)
  puts "Device: #{info.get_name} #{info.get_vendor} #{info.get_version} #{info.get_description}"
end

midiinfo = infos[1]
device = javax.sound.midi.MidiSystem.get_midi_device(midiinfo)

device.open

puts "Opened MIDI IN device: #{device.getDeviceInfo.name} #{device.getDeviceInfo.get_description}"
