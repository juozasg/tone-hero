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

	local waitTime = 0.1
	if self.time > waitTime then
		Gamestate.switch(playingChallenge)
	end
end

function idle:draw()
	love.graphics.print("Idle ... " .. self.time, 10, 10)
end




function playingChallenge:enter()
	self.challenge = {62, 60, 60} -- note stack
	self.noteOnTime = 0
	print("playingChallenge:enter", dump(self.challenge))
	self:playNextNote()
end

function playingChallenge:playNextNote()
	local note = table.remove(self.challenge) -- pop
	if note then love.note(note) end
end

function playingChallenge:hasRemainingNotes()
	return #self.challenge > 0
end

local noteLength = 1.8

function playingChallenge:update(dt)
	if self.noteOnTime > noteLength then
		if(self:hasRemainingNotes()) then
			self:playNextNote()
			self.noteOnTime = 0
		else
			Gamestate.switch(listeningAnswer)
		end
	end

	self.noteOnTime = self.noteOnTime + dt
end

function playingChallenge:draw()
	-- love.graphics.print("Will play ... " .. dump(1), 10, 10)
	love.graphics.print("Will play ... " .. dump(self.challenge), 10, 10)
end

function listeningAnswer:enter()
	self.answer = {}
end

function listeningAnswer:draw()
	-- love.graphics.print("Will play ... " .. dump(1), 10, 10)
	love.graphics.print("Your answer " .. dump(self.answer), 10, 10)
end

return {
	load = function(args)
		Gamestate.registerEvents()
    Gamestate.switch(idle)
	end,
	state = Gamestate
}

