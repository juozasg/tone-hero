if arg[2] == "debug" then
	require("lldebugger").start()
end


love.filesystem.setRequirePath("?.lua;?/init.lua;lib/?.lua;lib/?/init.lua;")

require("utils")
require("events")
local audio = require("audio")
local game = require("game")

love.window.setPosition(0,0,2)

love.window.setMode(200, 200, {fullscreentype="exclusive", fullscreen=false, vsync=true, minwidth=400, minheight=300})

function love.load(args)
	love.window.setTitle("Tone Hero - MIDI Game")
	audio.load(args)
	game.load(args)
	-- love.window.showMessageBox("Instructions", "Press any key to start", "info")
end

function love.draw()
	-- love.graphics.rectangle("line", 50, 50, 180, 150)
	love.graphics.print("R or A2 - Restart", 10, 260)
	love.graphics.print("Q or C2 - Quit", 10, 275)
end

function love.update(dt)
	audio.update(dt)
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end

-- shorthand for emiting notes that doesn't complain about unkown event type
function love.note(note)
---@diagnostic disable-next-line: param-type-mismatch
	love.event.push("note", note)
end