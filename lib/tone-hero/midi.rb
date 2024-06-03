require 'unimidi'
require 'tone-hero/midi/const'

def open_midi_in
  return UniMIDI::Input.open(0)
end
