class CLILyricsQuiz
  def initialize
    end

    def run
      puts
      puts
      puts "Welcome to the Lyrics Quiz CLI!".center(50)
      puts "*****************".center(50)
      puts

      puts
      puts

      is_running = true
      while is_running
        present_menu
        choice = STDIN.gets.chomp.to_i
        if choice == 1
          # play game
        elsif choice == 2
          # go to highscores
        elsif choice == 3
          how_to
        elsif choice == 4
          is_running = false
        end
      end
    end

    def present_menu
      puts "What would you like to do?"
      puts
      puts "1. Play a New Game"
      puts "2. Check High Scores"
      puts "3. How to Play"
      puts "4. Quit"
      puts
    end

    def how_to
      puts
      puts
      puts "How To Play".center(50)
      puts "*****************".center(50)
      puts
      puts "howtohowtohowtohowtohowto".center(50)
      puts
      puts"*****************".center(50)
      puts
    end
end
