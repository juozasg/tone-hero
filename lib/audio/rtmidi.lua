local ffi = require("ffi")

local MIDI = {}


ffi.cdef[[
int printf(const char *fmt, ...);

struct RtMidiWrapper {
	void* ptr;
	void* data;
	bool  ok;
	const char* msg;
};

typedef struct RtMidiWrapper* RtMidiPtr;
typedef struct RtMidiWrapper* RtMidiInPtr;
typedef struct RtMidiWrapper* RtMidiOutPtr;

enum RtMidiApi {
	RTMIDI_API_UNSPECIFIED,    /*!< Search for a working compiled API. */
	RTMIDI_API_MACOSX_CORE,    /*!< Macintosh OS-X CoreMIDI API. */
	RTMIDI_API_LINUX_ALSA,     /*!< The Advanced Linux Sound Architecture API. */
	RTMIDI_API_UNIX_JACK,      /*!< The Jack Low-Latency MIDI Server API. */
	RTMIDI_API_WINDOWS_MM,     /*!< The Microsoft Multimedia MIDI API. */
	RTMIDI_API_RTMIDI_DUMMY,   /*!< A compilable but non-functional API. */
	RTMIDI_API_WEB_MIDI_API,   /*!< W3C Web MIDI API. */
	RTMIDI_API_WINDOWS_UWP,    /*!< The Microsoft Universal Windows Platform MIDI API. */
	RTMIDI_API_ANDROID,        /*!< The Android MIDI API. */
	RTMIDI_API_NUM             /*!< Number of values in this enum. */
};

enum RtMidiErrorType {
	RTMIDI_ERROR_WARNING,           /*!< A non-critical error. */
	RTMIDI_ERROR_DEBUG_WARNING,     /*!< A non-critical error which might be useful for debugging. */
	RTMIDI_ERROR_UNSPECIFIED,       /*!< The default, unspecified error type. */
	RTMIDI_ERROR_NO_DEVICES_FOUND,  /*!< No devices found on system. */
	RTMIDI_ERROR_INVALID_DEVICE,    /*!< An invalid device ID was specified. */
	RTMIDI_ERROR_MEMORY_ERROR,      /*!< An error occurred during memory allocation. */
	RTMIDI_ERROR_INVALID_PARAMETER, /*!< An invalid parameter was specified to a function. */
	RTMIDI_ERROR_INVALID_USE,       /*!< The function was called incorrectly. */
	RTMIDI_ERROR_DRIVER_ERROR,      /*!< A system driver error occurred. */
	RTMIDI_ERROR_SYSTEM_ERROR,      /*!< A system error occurred. */
	RTMIDI_ERROR_THREAD_ERROR       /*!< A thread error occurred. */
};

typedef void(* RtMidiCCallback) (double timeStamp, const unsigned char* message,
size_t messageSize, void *userData);

const char* rtmidi_get_version();
int rtmidi_get_compiled_api (enum RtMidiApi *apis, unsigned int apis_size);
const char *rtmidi_api_name(enum RtMidiApi api);
const char *rtmidi_api_display_name(enum RtMidiApi api);
enum RtMidiApi rtmidi_compiled_api_by_name(const char *name);
void rtmidi_error (enum RtMidiErrorType type, const char* errorString);
void rtmidi_open_port (RtMidiPtr device, unsigned int portNumber, const char *portName);
void rtmidi_open_virtual_port (RtMidiPtr device, const char *portName);
void rtmidi_close_port (RtMidiPtr device);
unsigned int rtmidi_get_port_count (RtMidiPtr device);
int rtmidi_get_port_name (RtMidiPtr device, unsigned int portNumber, char * bufOut, int * bufLen);
RtMidiInPtr rtmidi_in_create_default (void);
RtMidiInPtr rtmidi_in_create (enum RtMidiApi api, const char *clientName, unsigned int queueSizeLimit);
void rtmidi_in_free (RtMidiInPtr device);
enum RtMidiApi rtmidi_in_get_current_api (RtMidiPtr device);
void rtmidi_in_set_callback (RtMidiInPtr device, RtMidiCCallback callback, void *userData);
void rtmidi_in_cancel_callback (RtMidiInPtr device);
void rtmidi_in_ignore_types (RtMidiInPtr device, bool midiSysex, bool midiTime, bool midiSense);
double rtmidi_in_get_message (RtMidiInPtr device, unsigned char *message, size_t *size);
RtMidiOutPtr rtmidi_out_create_default (void);
RtMidiOutPtr rtmidi_out_create (enum RtMidiApi api, const char *clientName);
void rtmidi_out_free (RtMidiOutPtr device);
enum RtMidiApi rtmidi_out_get_current_api (RtMidiPtr device);
int rtmidi_out_send_message (RtMidiOutPtr device, const unsigned char *message, int length);
]]

local indevice = nil

local buffer = ffi.new("unsigned char[1024]", {0})
local sizeptr = ffi.new("size_t[1]", {0})
local rtmidi

-- TODO: argv or user selectable port
-- local function print_midi_in_ports()
-- 	local ports = rtmidi.rtmidi_get_port_count(indevice)
-- 	for i=0,ports-1 do
-- 		local buf = ffi.new("char[256]")
-- 		local len = ffi.new("int[1]", {255})
-- 		rtmidi.rtmidi_get_port_name(indevice, i, buf, len)
-- 		print("Port " .. i .. ": " .. ffi.string(buf))
-- 	end
-- end

function MIDI.dump_buffer()
	if indevice then

		local ts = rtmidi.rtmidi_in_get_message(indevice, buffer, sizeptr)
		assert(indevice.ok, ffi.string(indevice.msg))

		if sizeptr[0] > 0 then
			print("mm", ffi.string(buffer, sizeptr[0]))
		end
	end
end

function MIDI.open_port(portNumber)
	print("FFI os:" .. ffi.os .. " arch:" .. ffi.arch)

	assert(ffi.os == "OSX", "Only OS X supported for now")

	rtmidi = ffi.load("rtmidi")
	local version = rtmidi.rtmidi_get_version()
	print("rtmidi version " .. ffi.string(version))

	indevice = rtmidi.rtmidi_in_create_default()

	-- print_midi_in_ports()

	local buf = ffi.new("char[256]")
	local len = ffi.new("int[1]", {255})
	rtmidi.rtmidi_get_port_name(indevice, portNumber, buf, len)
	print("Selected MIDI IN portNumber=" .. portNumber .. ": " .. ffi.string(buf))

	rtmidi.rtmidi_open_port(indevice, portNumber, "tone-hero midi in")
	assert(indevice.ok, ffi.string(indevice.msg))

	-- BUGGY SEGFAULT
	-- rtmidi.rtmidi_in_set_callback(indevice, midiDataCb, nil)
	-- assert(indevice.ok, ffi.string(indevice.msg))
end





return MIDI


