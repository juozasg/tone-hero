local sound = require("lib.audio.player")

---@diagnostic disable-next-line: undefined-field
function love.handlers.note(code)
		print("handlers.note", code)
		sound.play_note(code)
end