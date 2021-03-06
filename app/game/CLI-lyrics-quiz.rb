class CLILyricsQuiz
  def initialize
    # prompt = TTY::Prompt.new
  end

  #starts the program
  def run
    puts
    puts "Welcome to the Lyrics Quiz CLI!".center(50).light_magenta
    puts
    puts "*****************".center(50).light_cyan
    is_running = true
    while is_running
      #returns choice from the main menu
      choice = present_menu
      if choice == "Play"
        #starts a game. Passes through the results of the set_ methods
        game(set_genre, set_options, set_difficulty)
      elsif choice == "Check_Scores"
        # goes to highscores
        show_high_scores
      elsif choice == "How_To"
        #instructions for the game
        how_to
      elsif choice == "Quit"
        #kicks out of the while-loop, stops running
        puts "BAI!".light_magenta.blink
        is_running = false
      end
    end
  end

  #shows the main menu
  def present_menu
    puts
    puts
    prompt = TTY::Prompt.new
    result = prompt.select("What would you like to do?".light_magenta, %w(Play Check_Scores How_To Quit))
    puts
    puts #PLACEMENT OF PUTS IS IMPORTANT!!!
    result
  end

  # creates a new game
  def game(genre, options, difficulty)
    round = 1
    num_rounds = 10
    total_points = 0
    while round <= num_rounds
      #displays choices and keeps track of correct answers
      round_point = run_round(round, genre, options, difficulty)
      total_points += round_point
      puts
      sleep(1)
      if round == 10
        #breaks out of the loop without showing end_round_options
        round += 1
      else
        #round_choice is return of #end_round_options
        round_choice = end_round_options
        if round_choice == nil || round_choice == "\r"
          #goes to next round
          round += 1
        elsif round_choice == "\e"
          #breaks the game's while loop and goes back to the main menu
          round = 11
        end
      end
    end
    #displays points at the end of 10 rounds
    display_points(total_points)
  end

  def run_round(round, genre, options, difficulty)
    point = 0
    #creates an array of random songs from chosen genre with chosen # of title options
    choices = pick_choices(genre, options)
    #get titles of choices to display
    titles = take_titles(choices)
    #creates a snippet from the first song in choices array = first song
    #is defaulted to "correct answer"
    snippet = Search.get_lyric_sample(choices[0].lyrics, difficulty)

    puts
    puts "***** Round #{round}! *****".center(50).light_green
    puts
    puts ("♪♫~~  " + snippet + " ~~♪♫").light_cyan
    puts
    puts

    #correct_answer is return value of #display_make_choices
    correct_answer = display_make_choices(titles) #boolean
    if correct_answer #true
      answer_response("Yes".green.blink, choices[0])
      point += 1
    else #false
      answer_response("NOPE".red.blink, choices[0])
    end
    #returns a 0 or 1 as a point
    point
  end

  #displays choices array to user
  def display_make_choices(choices_array)
    #redundant, but too lazy to change
    choices = choices_array
    #randomizes the choices/possible_answers in the array
    possible_answers = choices.shuffle
    correct_answer = nil
    prompt = TTY::Prompt.new

    answer_input = prompt.select("Which song is this from?".light_magenta) do |menu|
      #iterates through each choice and prints it out as menu option,
      #with return value of i + 1 when chosen
      possible_answers.length.times do |i|
        menu.choice possible_answers[i], i + 1
        if possible_answers[i] == choices[0]
          #keeps track of which option is the correct answer
          correct_answer = i + 1
        end
      end
    end
    #compares whether the answer chosen is the correct
    #answer, returns boolean
    correct_answer == answer_input
  end

  def display_points(total_points)
    puts
    puts
    puts
    puts "***** Noice. *****".center(50).green
    puts "You got #{total_points} points!".center(50).light_cyan
    puts
    puts
    puts
  end

  def set_genre
    genre_id = nil
    puts
    puts
    prompt = TTY::Prompt.new
    genre_input = prompt.select("Pick a genre you\'d like to work with".light_magenta) do |menu|
      6.times do |i|
        menu.choice Search.get_genres[i], i + 1
      end
    end
    puts
    puts
    level_chooser(genre_input)
  end

  def set_difficulty
    puts
    puts
    prompt = TTY::Prompt.new
    diff_input = prompt.select("How well do you know your stuff?".light_magenta) do |menu|
      menu.choice 'What\'s a radio?',  1
      menu.choice 'I listen regularly', 2
      menu.choice 'LET\'S DO THIS',  3
    end
    puts
    puts
    level_chooser(diff_input)
  end

  def set_options
    option_num = nil
    puts
    puts
    prompt = TTY::Prompt.new
    option_input = prompt.select("How confident are you?".light_magenta) do |menu|
      menu.choice 'Not very',  1
      menu.choice 'I\'m ok', 2
      menu.choice 'I GOT THIS',  3
    end
    puts
    puts
    level_chooser(option_input * 2)
  end

  def level_chooser(prompt_input)
    input = prompt_input
    level = nil
    if input == 1
      level = 1
    elsif input == 2
      level = 2
    elsif input == 3
      level = 3
    elsif input == 4
      level = 4
    elsif input == 5
      level = 5
    elsif input == 6
      level = 6
    end
    level
  end

  def take_titles(choices)
    choices.collect do |i|
      i.title
    end
  end

  def end_round_options
    puts
    prompt = TTY::Prompt.new
    output = prompt.keypress("Press ENTER to continue, \nPress ESC to quit, \nResumes automatically in :countdown ...",  timeout: 3, keys: [:escape, :return])
    puts
    puts
    output
  end

  def pick_choices(genre_id, option_num)
    choices = Search.get_question_by_genre(genre_id, option_num)
    choices
  end

  def answer_response(yes_or_no, first_choice)
    puts
    puts
    puts "***** #{yes_or_no} *****".center(50)
    puts
    puts "It was from '#{first_choice.title.light_yellow}'".center(50)
    puts "by #{first_choice.artist.name.light_yellow}".center(50)
    puts
    puts
  end
  end

  def show_high_scores
    puts Search.get_scoreboard
  end

  def how_to
    puts
    puts
    puts "How To Play".center(50).light_magenta
    puts "*****************".center(50).light_cyan
    puts
    puts "1. Select a Genre".center(50)
    puts "2. Select an option difficulty (number of choices to pick from)".center(50)
    puts "2. Select a line difficulty (amount of lyrics given)".center(50)
    puts "3. You will be given lyrics from a song".center(50)
    puts "4. Use the arrow keys to select your guess".center(50)
    puts
    puts"*****************".center(50).light_cyan
    puts
  end
