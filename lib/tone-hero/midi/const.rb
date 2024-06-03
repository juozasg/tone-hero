require 'midi-message'

NoteOn = 0x90
NoteOff = 0x91

def note_code(note)
  MIDIMessage::Constant.value('Note', note)
end

def note_name(note)
  MIDIMessage::Constant::Group['Note'].constants.find { |x| x.value == note }.key
end
