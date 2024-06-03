require "tone-hero/midi/const"
require "rtmidi"


def select_midi_port(midiio)
  print "Select a port number: "
  if (port = gets) =~ /^\d+$/
    return port.to_i if (0...midiio.port_count).include? port.to_i
  end
  puts "Invalid port number"
end


def listen_channel_midi
  midiin = RtMidi::In.new

  midiin.receive_channel_message do |byte1, byte2, byte3|
    yield byte1, byte2, byte3
  end



  midiin.open_port(1)

    # puts "Available MIDI input ports"
  # midiin.port_names.each_with_index{|name,index| printf "%3i: %s\n", index, name }

  # port_index = select_midi_port(midiin) until port_index
end


# ##############################################################################
# # Use this approach when you need to receive any message including:
# # System Exclusive (SysEx), timing, active sensing
# midiin.receive_message do |*bytes|
#   yield bytes
# end
