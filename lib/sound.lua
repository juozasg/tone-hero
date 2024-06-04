local denver = require 'lib.denver'

local sfxGood = love.audio.newSource("assets/good.ogg", "static")
local sfxBad = love.audio.newSource("assets/badd.ogg", "static")

local Sound = {}

-- love.audio.setEffect("eq", {type="equalizer", highmidgain = 0.6,  highgain=0, highcut=4000})

function Sound.play_note(code)
	local square = denver.get({waveform='square', frequency='F4', length=0.8})
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