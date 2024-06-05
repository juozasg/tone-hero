require 'lib.audio.midi'
local denver = require 'lib.audio.denver'

local sfxGood = love.audio.newSource("assets/good.ogg", "static")
local sfxBad = love.audio.newSource("assets/badd.ogg", "static")

local Sound = {}

-- love.audio.setEffect("eq", {type="equalizer", highmidgain = 0.6,  highgain=0, highcut=4000})
-- c4= 60

function Sound.play_note(code)
	local noteName = MIDI_code_to_note_name(code)
	print("♪ " .. noteName .. " ♪")
	local square = denver.get({waveform='square', frequency=noteName, length=0.8})
	love.audio.setVolume(0.7)
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