local sound = require("audio.sound-player")
local game = require("game")

---@diagnostic disable-next-line: undefined-field
function love.handlers.note(code)
	print("note", code)
	if(code == 45) then
		game.restart()
	elseif(code == 48) then
		love.event.quit()
	else
		sound.play_note(code)
		game.note(code)
	end
end