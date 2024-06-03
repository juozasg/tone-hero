require 'tone-hero/2d'


module ToneHero

include Ruby2D
extend Ruby2D::DSL

  class MainLoop
    def initialize(input)
      @input = input
      @notes_on = []
      @tick = 0
    end


    def run
      Window.update do
        if @tick % 60 == 0
          Window.set background: 'random'
        end
        @tick += 1
        # pp @notes_on
      end

      # Thread.new do
        puts "Reading MIDI..."
        loop do
          m = @input.gets

          msg, note, _ = m[0][:data]

          if(msg == NoteOn) then
            ToneHero.text "NoteOn: #{note_name(note)}"
            @notes_on << note
          end
        end
      # end

      # Window.show

    end
  end
end
