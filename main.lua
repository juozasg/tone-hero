if arg[2] == "debug" then
	require("lldebugger").start()
end

-- function love.draw()
-- 	love.graphics.print("Hello World!", 100, 100)
-- end

text = "Hello World!"
print(text)


function love.load()
	-- song = love.audio.newSource("path/to/song.ogg", "stream")
	-- song:setLooping(true)
	-- song:play()

	-- sfx is short for 'sound effect', or at least I use it like that.
	sfxGood = love.audio.newSource("good.ogg", "static")
	sfxBad = love.audio.newSource("badd.ogg", "static")
	x = 100
	fps = 0
end


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
