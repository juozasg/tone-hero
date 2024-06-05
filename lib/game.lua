Gamestate = require "hump.gamestate"

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


function playingChallenge:enter()
	self.challenge = {62, 60, 60} -- note stack
	self.noteOnTime = 0
end

local noteLength = 0.8

function playingChallenge:update(dt)
	local finishedPlaying = #self.challenge == 0 and self.noteOnTime > noteLength

	if self.noteOnTime > noteLength then
		self.noteOnTime = 0
		if(#self.challenge > 0) then
			local note = table.remove(self.challenge) -- pop
			love.note(note)
		end
	end

	if(finishedPlaying) then
		Gamestate.switch(listeningAnswer)
	elseif self.noteOnTime > noteLength then
		self.noteOnTime = self.noteOnTime + dt
	end


end

return {
	load = function(args)
		Gamestate.registerEvents()
    Gamestate.switch(idle)
	end,
	state = Gamestate
}

