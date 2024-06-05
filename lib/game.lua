Gamestate = require "hump.gamestate"

local sound = require("audio.sound-player")

-- states
local idle = {
	time = 0
}

local playingChallenge = {}
local listeningAnswer = {}
local score = {}

function idle:enter()
	self.time = 0
end

function idle:update(dt)
	self.time = self.time + dt

	local waitTime = 0.5
	if self.time > waitTime then
		Gamestate.switch(playingChallenge)
	end
end

function idle:draw()
	love.graphics.print("Thinking ... ", 10, 10)
end

function playingChallenge:init()
	self.challenge = {60, 60, 62} -- note stack
	self.playQueue = {}
	for k, v in ipairs(self.challenge) do
		table.insert(self.playQueue, v)
	end
	self.noteOnTime = 0
end

function playingChallenge:enter()
	self:init()
	print("playingChallenge:enter", dump(self.playQueue))
	self:playNextNote()
end

function playingChallenge:playNextNote()
	local note = table.remove(self.playQueue, 1)
	if note then love.note(note) end
end

function playingChallenge:hasRemainingNotes()
	return #self.playQueue > 0
end

local noteLength = 1

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

function playingChallenge:label()
	local label = ""
	for i, v in ipairs(self.challenge) do
		local played = "o"
		local notPlayed = "?"
		local notesPlayed = #self.challenge - #self.playQueue
		if i > notesPlayed then
			label = label .. notPlayed
		else
			label = label .. played
		end

		-- if i > 1 and i + 1 < #self.challenge then
			label = label .. "    "
		-- end
	end

	return label
end

function playingChallenge:draw()
	love.graphics.print("Challenge  " .. self:label() , 10, 10)
end

function listeningAnswer:init()
	self.answer = {}
	self.transitionWait = noteLength
end

function listeningAnswer:enter()
	self:init()
	print("listeningAnswer:enter", dump(self.answer))
end

function listeningAnswer:draw()
	-- love.graphics.print("Will play ... " .. dump(1), 10, 10)
	playingChallenge:draw()
	local label = ""
	for i, v in ipairs(self.answer) do
		local name = MIDI_code_to_note_name(v)
		label = label .. name .. "  "
	end
	love.graphics.print("Answer      " .. label, 10, 30)
end

function listeningAnswer:update(dt)
	if(#self.answer >= #playingChallenge.challenge) then
		self.transitionWait = self.transitionWait - dt
		if(equals(self.answer, playingChallenge.challenge)) then
			if self.transitionWait < 0 then Gamestate.switch(score, 'win') end
		else
			if self.transitionWait < 0 then Gamestate.switch(score, 'lose') end
		end
	end
end

function score:enter(prev, result)
	self.result = result
	self.score = 420

	if self.result == 'win' then
		sound.play_good()
	else
		sound.play_bad()
	end
end

function score:draw()
	listeningAnswer:draw()
	love.graphics.push()
	love.graphics.scale(2, 2)

	if self.result == 'win' then
		love.graphics.print({{0.20, 0.9, 0.4}, "#WINNING"}, 5, 30)
	else
		love.graphics.print({{1, 0.1, 0.2}, "BIG L"}, 5, 30)
	end
	love.graphics.pop()


	love.graphics.print("SCORE: ".. self.score, 10, 90)
end

local function note(code)
	if(Gamestate.current() == listeningAnswer) then
		table.insert(Gamestate.current().answer, code)
	end
end

return {
	load = function(args)
		Gamestate.registerEvents()
    Gamestate.switch(idle)
	end,
	note = note,
	restart = function()
		Gamestate.switch(idle)
		-- playingChallenge:init()
		-- listeningAnswer:init()
		-- Gamestate.switch(score, 'win')
	end,
	state = Gamestate
}

