Gamestate = require "lib.hump.gamestate"

-- states
local idle = {
	time = 0
}

local playingChallenge = {}
local listeningAnswer = {}
local showingScore = {}


function idle:enter()
	self.time = 0
end

function idle:update(dt)
	self.time = self.time + dt

	if self.time > 2 then
		Gamestate.switch(playingChallenge)
	end
end

function idle:draw()
	love.graphics.print("Idle ... " .. self.time, 10, 10)
end

return {
	load = function(args)
		Gamestate.registerEvents()
    Gamestate.switch(idle)
	end,
	state = Gamestate
}

