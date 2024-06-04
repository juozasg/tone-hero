if arg[2] == "debug" then
	require("lldebugger").start()
end

local midi = require("lib.rtmidi")
local sound = require("lib.sound")

love.window.setPosition(0,0,2)

love.window.setMode(1000, 1000, {fullscreentype="exclusive", fullscreen=false, vsync=true, minwidth=400, minheight=300})

function love.load(args)
	midi.open_port(tonumber(args[1]) or 0)
end


function love.draw()
	love.graphics.rectangle("line", 100, 50, 200, 150)
end

function love.update(dt)
	midi.dump_buffer()
end

function love.keypressed(key)
	if key == "space" then
		sound.play_good()
	elseif key == "b" then
		sound.play_bad()
	elseif key == "n" then
		sound.play_note()
	end

	if key == "escape" or key =="q" then
		love.event.quit()
	end
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end