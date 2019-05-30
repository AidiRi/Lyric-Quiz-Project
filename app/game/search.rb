require_relative '../../config/environment.rb'


# The purpose of this class is to be a layer of interaction in between
# the database and the CLI view
class Search < ActiveRecord::Base

    # This method returns an array of all the geners in the db
    def self.get_genres
      Genre.all.collect.with_index do |genre, i|
        "#{i + 1}. #{genre.name}"
      end
    end

    # This method takes in a genre id and difficulty and returns
    # and array where array.length = difficulty. The array contains
    # random songs in that genre
    def self.get_question_by_genre(genre_id, difficulty)
        possibile_songs_in_genre = GenreSong.where(genre_id: genre_id)
        possible_questions = possibile_songs_in_genre.sample(difficulty)
        return possible_questions.collect do |genre_song|
            Song.find_by(id: genre_song.song_id)
        end
    end

    # This method takes in lyrics as a string and returns a random chunk
    # from those lyrics
    def self.get_lyric_sample(lyrics, difficulty)
        lyric_array = lyrics.split('", "')
        ray_len = lyric_array.length
        # Randomized option
        # amount_of_lines = rand(4..(8 - difficulty))
        # Static option
        amount_of_lines = 6 - difficulty
        limit = (ray_len - 1) - amount_of_lines
        start_index = rand(0..limit)
        end_index = start_index + amount_of_lines - 1
        result = ""
        lyric_array[start_index..end_index].each do |line|
            result += "#{line}\n"
        end
        return result
    end

    # This method takes in a song object and returns the name of that artist
    def self.get_artist(song)
        return Artist.find_by(id: song.artist_id).name
    end

    # This method takes in a user name and a score. If the record
    # already exists and if the new score is higher than the old
    # score, then the record is updated
    def self.add_new_score(user_name, new_score)
        score = Score.find_or_create_by(user_name: user_name)
        if score.score == nil || score.score < new_score
            score.update(score: new_score)
        end
    end

    # This method returns the Top 10 scores as a string
    def self.get_scoreboard
        leaderboard = ""
        scores = Score.all.order(score: :desc).limit(10)
        scores.each do |score|
            leaderboard += "#{score.user_name} :::: #{score.score}\n".center(50)
        end
        return leaderboard
    end
end
