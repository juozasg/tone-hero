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
	sfx = love.audio.newSource("good.ogg", "static")
end

function love.keypressed(key)
	if key == "space" then
			sfx:play()
	end

	if key == "escape" or key =="q" then
		love.event.quit()
	end
end

-- love.event.quit()
