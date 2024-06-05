if arg[2] == "debug" then
	require("lldebugger").start()
end

local audio = require("lib.audio")
require("lib.events")

love.window.setPosition(0,0,2)

love.window.setMode(200, 200, {fullscreentype="exclusive", fullscreen=false, vsync=true, minwidth=400, minheight=300})

function love.load(args)
	audio.load(args)
end


function love.draw()
	love.graphics.rectangle("line", 20, 20, 180, 150)
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