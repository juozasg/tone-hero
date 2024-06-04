
local sfxGood = love.audio.newSource("assets/good.ogg", "static")
local sfxBad = love.audio.newSource("assets/badd.ogg", "static")

local Sound = {}

function Sound.play_note(code)
end

function Sound.play_good()
	sfxGood:play()
end

function Sound.play_bad()
	sfxBad:play()
end


return Sound