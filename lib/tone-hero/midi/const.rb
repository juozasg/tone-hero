require 'midi-message'

NoteOn = 0x90
NoteOff = 0x91

# c3 = 48 = MIDIMessage::Constant.value('Note', 'C3')
# name = 'C3' = MIDIMessage::Constant::Group['Note'].constants.find { |x| x.value == 48 }.key


def note_code(note)
  MIDIMessage::Constant.value('Note', note)
end

def note_name(note)
  MIDIMessage::Constant::Group['Note'].constants.find { |x| x.value == note }.key
end
