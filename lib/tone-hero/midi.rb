require 'unimidi'
require 'tone-hero/midiconst'





def open_midi_in
  return UniMIDI::Input.open(0)
end
