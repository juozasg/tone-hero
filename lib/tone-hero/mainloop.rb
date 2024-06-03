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

    def read_notes
      loop do
        events = @input.gets
        # pp events
        events.each do |e|
          # pp e

          code, note, _ = e[:data]
          if(code == NoteOn)
            @notes_on << note_name(note)
            # puts note_name(note)
          end
        end

        if(@notes_on.length > 0)
          pp @notes_on
          @notes_on = []
        end
      end
    end




    def run
      # Window.update do
      # Thread.new { read_notes }
      read_notes

      t = Time.now
      Window.update do
        if @tick % 60 == 0
          Window.set background: 'random'
          # puts "60 frams in #{Time.now - t} seconds"
          t = Time.now
          puts ""
          # pp @input
        end
        @tick += 1

        sleep 0.01

        if(@notes_on.length > 0)
          pp @notes_on
          @notes_on = []
        end



      end

      Window.show

    end
  end
end
