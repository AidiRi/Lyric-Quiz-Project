require 'pry'
require 'open-uri'
require 'nokogiri'
require './app/models/genre.rb'
top_50_page = Nokogiri::HTML(open("html-pages/genius-top-50.html"))
rap_page = Nokogiri::HTML(open("html-pages/genius-rap.html"))
country_page = Nokogiri::HTML(open("html-pages/genius-country.html"))
pop_page = Nokogiri::HTML(open("html-pages/genius-pop.html"))
rb_page = Nokogiri::HTML(open("html-pages/genius-rb.html"))
rock_page = Nokogiri::HTML(open("html-pages/genius-rock.html"))

def find_links(page)
  links = page.css("a").collect do |a|
      a["href"]
    end
    links
end
humble = Nokogiri::HTML(open("https://genius.com/Kendrick-lamar-humble-lyrics"))


find_links(country_page)
g1 = Genre.new(name: "pop")

ids = GenreSong.where("genre_id = 1").pluck(:id)
song1 = GenreSong.find(ids.sample).song.title
song2 = GenreSong.find(ids.sample).song.title
song3 = GenreSong.find(ids.sample).song.title
song4 = GenreSong.find(ids.sample).song.title
