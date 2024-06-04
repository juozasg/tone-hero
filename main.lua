if arg[2] == "debug" then
	require("lldebugger").start()
end


local ffi = require("ffi")

ffi.cdef[[
int printf(const char *fmt, ...);
]]
ffi.C.printf("Hello C %s!\n", "world")


-- function love.draw()
-- 	love.graphics.print("Hello World!", 100, 100)
-- end

text = "Hello World!"
print(text)

love.window.setPosition(0,0,2)

love.window.setMode(1000, 1000, {fullscreentype="exclusive", fullscreen=false, vsync=true, minwidth=400, minheight=300})

function love.load()
	-- song = love.audio.newSource("path/to/song.ogg", "stream")
	-- song:setLooping(true)
	-- song:play()

	-- sfx is short for 'sound effect', or at least I use it like that.
	sfxGood = love.audio.newSource("good.ogg", "static")
	sfxBad = love.audio.newSource("badd.ogg", "static")
	x = 100
end

fps = 0


function love.draw()
	love.graphics.rectangle("line", x, 50, 200, 150)

	-- love.graphics.print("Hello World!", 400, 300)
	love.graphics.print("FPS: " .. fps, 400, 320)
end

function love.update(dt)
	fps = math.floor(1/dt)

	x = x + 5
end

function love.keypressed(key)
	if key == "space" then
			sfxGood:play()
	elseif key == "b" then
			sfxBad:play()
	end

	if key == "escape" or key =="q" then
		love.event.quit()
	end
end

-- love.event.quit()


local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end