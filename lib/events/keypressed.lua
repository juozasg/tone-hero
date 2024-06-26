---@diagnostic disable: param-type-mismatch

local sound = require("audio.sound-player")

local game = require("game")

function love.keypressed(key)
	if key == "space" then
		sound.play_good()
	elseif key == "b" then
		sound.play_bad()
	end

	if key == "a" then
		love.event.push("note", 60) -- C
	elseif key == "s" then
		love.event.push("note", 62) -- D
	elseif key == "d" then
		love.event.push("note", 64) -- E
	elseif key == "f" then
		love.event.push("note", 65) -- F
	end

	if key == "escape" or key =="q" then
		love.event.quit()
	elseif key == "b" then
		print(game, type(game), game.state, type(game.state))
		local breakhere = 1;
	elseif key == "r" then
		game.restart()
	end
end