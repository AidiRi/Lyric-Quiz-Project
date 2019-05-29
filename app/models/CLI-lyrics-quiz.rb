class CLILyricsQuiz
  def initialize
  end

  def run
    puts
    puts
    puts "Welcome to the Lyrics Quiz CLI!".center(50)
    puts "*****************".center(50)
    is_running = true
    while is_running
      present_menu
      choice = STDIN.gets.chomp.to_i
      if choice == 1
        game
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
    puts
    puts
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

  def game
    round = 1
    num_rounds = 10
    while round <= num_rounds
      puts
      puts "***** Round #{round}! *****".center(50)
      puts
      puts
      display_choices
      puts
      round_options
      input = STDIN.gets.to_s
      if input == "\n"
        round += 1
      elsif input == "q\n"
        round = 11
      end
    end
  end

  def round_options
    puts
    puts "Press enter to move on"
    puts "Press q to quit"
    puts
    puts
  end

  def display_choices
    choices = ["s1", "s2", "s3", "s4"]
    possible_answers = choices.shuffle
    correct_answer = nil
    possible_answers.each.with_index do |answer, i|
      puts "#{i + 1}.  #{answer}"
      if answer == choices[0]
        correct_answer = i + 1
      end
    end
    input = STDIN.gets.chomp.to_i
    if input == correct_answer
      answer_response("Yes")
    else
      answer_response("NOPE")
    end
  end

  def answer_response(yes_or_no)
    puts
    puts
    puts "***** #{yes_or_no}! *****".center(50)
    puts
    # display lyrics
    # display title/artist
    puts
    puts
  end
end
