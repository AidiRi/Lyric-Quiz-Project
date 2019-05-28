class Genre < ActiveRecord::Base
  has_many :songs, through: :genre_songs
end
