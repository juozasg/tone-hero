local sound = require("audio.player")

---@diagnostic disable-next-line: undefined-field
function love.handlers.note(code)
		sound.play_note(code)
end