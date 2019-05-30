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
      choice = present_menu
      if choice == "Play"
        game(set_genre, set_options, set_difficulty)
      elsif choice == "Check_Scores"
        # go to highscores -- still needs to be added in
      elsif choice == "How_To"
        how_to #instructions for the game
      elsif choice == "Quit"
        is_running = false #kicks out of the while-loop, stops running
      end
    end
  end

  def present_menu
    puts
    puts
    prompt = TTY::Prompt.new
    result = prompt.select("What would you like to do?", %w(Play Check_Scores How_To Quit))
    puts
    puts
    result
  end

  def set_difficulty
    puts
    puts
    prompt = TTY::Prompt.new
    diff_input = prompt.select('How well do you know your stuff?') do |menu|
      menu.choice 'What\'s a radio?',  1
      menu.choice 'I listen regularly', 2
      menu.choice 'LET\'S DO THIS',  3
    end
    puts
    puts
    # puts "How well do you know your stuff?"
    # puts "1. What's a radio?"
    # puts "2. I listen regularly"
    # puts "3. LET'S DO THIS"
    # input = STDIN.gets.chomp.to_i
    level_chooser(diff_input)
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
    end
    level
  end

  def set_options
    option_num = nil
    puts
    puts
    puts "How confidant are you?"
    puts "1. Not very"
    puts "2. I'm ok"
    puts "3. I GOT THIS"
    puts
    input = STDIN.gets.chomp.to_i
    if input == 1
      option_num = 2
    elsif input == 2
      option_num = 4
    elsif input == 3
      option_num = 6
    end
    option_num
  end

  def set_genre
    genre_id = nil
    puts
    puts
    puts "Pick a genre you'd like to work in:"
    puts Search.get_genres
    puts
    input = STDIN.gets.chomp.to_i
    if input == 1
      genre_id = 1
    elsif input == 2
      genre_id = 2
    elsif input == 3
      genre_id = 3
    elsif input == 4
      genre_id = 4
    elsif input == 5
      genre_id = 5
    elsif input == 6
      genre_id = 6
    else
      puts "Not a valid option"
    end
    genre_id
  end



  def how_to
    puts
    puts
    puts "How To Play".center(50)
    puts "*****************".center(50)
    puts
    puts "1. Select a Genre".center(50)
    puts "2. Select a Difficulty".center(50)
    puts "3. You will be given lyrics from a song".center(50)
    puts "4. Use the arrow keys to select your guess".center(50)
    puts
    puts"*****************".center(50)
    puts
  end

  def game(genre, options, difficulty)
    round = 1
    num_rounds = 10
    total_points = 0
    while round <= num_rounds
      round_point = run_round(round, genre, options, difficulty)
      total_points += round_point
      puts
      sleep(1)
      if round == 10
        round += 1
      else
        round_options
        input = STDIN.gets.to_s
        if input == "\n"
          round += 1
        elsif input == "q\n"
          round = 11
        end
      end
    end
    display_points(total_points)
  end

  def run_round(round, genre, options, difficulty)
    point = 0
    choices = pick_choices(genre, options)
    titles = take_titles(choices)#get titles of choices
    snippet = Search.get_lyric_sample(choices[0].lyrics, difficulty)
    puts
    puts "***** Round #{round}! *****".center(50)
    puts
    puts "♪♫~~  " + snippet + " ~~♪♫"
    puts
    puts
    puts "Which song is this from?"
    correct_answer = display_choices(titles)
    input = STDIN.gets.chomp.to_i
    if input == correct_answer
      answer_response("Yes", choices[0])
      point += 1
    else
      answer_response("NOPE", choices[0])
    end
    point #need to add together with other rounds and put sum into display_points
  end

  def display_points(total_points)
    puts
    puts "***** Noice. *****".center(50)
    puts "You got #{total_points} points!".center(50)
    puts
    puts
  end

  def take_titles(choices)
    choices.collect do |i|
      i.title
    end
  end

  def round_options
    puts
    puts "Press enter to move on"
    puts "Press q to quit"
    puts
    puts
  end

  def pick_choices(genre_id, option_num)
    choices = Search.get_question_by_genre(genre_id, option_num)
    choices
  end

  def display_choices(choices_array)
    choices = choices_array
    possible_answers = choices.shuffle
    correct_answer = nil
    possible_answers.each.with_index do |answer, i|
      puts "#{i + 1}.  #{answer.strip}"
      if answer == choices[0]
        correct_answer = i + 1
      end
    end
    correct_answer
  end

  def answer_response(yes_or_no, first_choice)
    puts
    puts
    puts "***** #{yes_or_no}! *****".center(50)
    puts #when adding colors, use if= yes_or_no == "Yes!"/"NOPE"...
    puts "It was from '#{first_choice.title}'".center(50)
    puts "by #{first_choice.artist.name}".center(50)
    puts
    puts
  end
end
