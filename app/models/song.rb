class Song < ActiveRecord::Base
  has_many :genres, through: :genre_songs
  belongs_to :artist
end
