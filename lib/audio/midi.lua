local nodeNumber = {
	C = 0,
	Db = 1,
	D = 2,
	Eb = 3,
	E = 4,
	F = 5,
	Gb = 6,
	G = 7,
	Ab = 8,
	A = 9,
	Bb = 10,
	B = 11,
}

function MIDI_code_to_note_name(code)
	local noteIndex = code % 12
	local noteName = "C"
	for k, v in pairs(nodeNumber) do
		if v == noteIndex then
			noteName = k
			break
		end
	end

	local octave = (math.floor(code / 12)) - 1
	return noteName .. octave
end
