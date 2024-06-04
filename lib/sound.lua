local denver = require 'lib.denver'

local sfxGood = love.audio.newSource("assets/good.ogg", "static")
local sfxBad = love.audio.newSource("assets/badd.ogg", "static")

local Sound = {}

-- love.audio.setEffect("eq", {type="equalizer", highmidgain = 0.6,  highgain=0, highcut=4000})
-- c4= 60
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

local function midi_code_to_note_name(code)
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

function Sound.play_note(code)
	local noteName = midi_code_to_note_name(60)
	print('for 60', noteName)
	local square = denver.get({waveform='square', frequency=noteName, length=0.8})
	love.audio.setVolume(0.7)
	-- square:setEffect("lowpass")
	square:setFilter{ type="lowpass", volume=0.5, highgain=0.4 }
	love.audio.play(square)
end

function Sound.play_good()
	sfxGood:play()
end

function Sound.play_bad()
	sfxBad:play()
end


return Sound