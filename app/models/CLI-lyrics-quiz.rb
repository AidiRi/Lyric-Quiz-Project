class CLILyricsQuiz
  def initialize
    end

    def run
      puts
      puts
      puts "Welcome to the Lyrics Quiz CLI!".center(50)
      puts "*****************".center(50)
      puts
      present_menu
      puts
      puts

    end

    def present_menu
      puts "What would you like to do?"
      puts
      puts "1. Play a New Game"
      puts "2. Check High Scores"
      puts "3. How to Play"
      puts "4. Quit"
    end
end
