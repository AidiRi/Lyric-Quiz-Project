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
        # g_genre = set_genre
        # g_options = set_options
        game(set_genre, set_options)
      elsif choice == 2
        # go to highscores -- still needs to be added in
      elsif choice == 3
        how_to #instructions for the game
      elsif choice == 4
        is_running = false #kicks out of the while-loop, stops running
      end
    end
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

  def game(genre, options)
    round = 1
    num_rounds = 10
    total_points = 0
    while round <= num_rounds
      round_point = run_round(round, genre, options)
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
    # run_round(round, genre, options)
    display_points(total_points)
  end

  def run_round(round, genre, options)
    point = 0
    choices = pick_choices(genre, options)
    titles = take_titles(choices)#get titles of choices
    snippet = Search.get_lyric_sample(choices[0].lyrics)
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
