local rmidi = require "lib.audio.rtmidi"

return {
	update = function(dt)
		rmidi.dump_buffer()
	end,

	load = function(args)
		rmidi.open_port(tonumber(args[1]) or 0)
	end
}