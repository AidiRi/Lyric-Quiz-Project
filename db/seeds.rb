require_relative '../config/environment.rb'

# Genres
all_genres = {
  "Top 50": Nokogiri::HTML(open("html-pages/genius-top-50.html")),
  "Rap": Nokogiri::HTML(open("html-pages/genius-rap.html")),
  "Country": Nokogiri::HTML(open("html-pages/genius-country.html")),
  "Pop": Nokogiri::HTML(open("html-pages/genius-pop.html")),
  "R n B": Nokogiri::HTML(open("html-pages/genius-rb.html")),
  "Rock": Nokogiri::HTML(open("html-pages/genius-rock.html"))
}

# This method takes in a page (parsed HTML) and returns a list 
# of urls of songs that are in that genre
def find_links(page)
  links = page.css("a").collect do |a|
      a["href"]
    end
    links
end

# This method takes a song link and parses the html 
# Returns a hash containing song name, artist name, and the lyrics
def extract_song_info(link)
    parsed_html = Nokogiri::HTML(open(link))
    lyrics = parsed_html.css("[class = lyrics]").inner_text.strip.split("\n")
    lyrics = lyrics.select do |line|
        line != nil && line != "" && !line.include?("[") 
    end
    artist_name = parsed_html.css("[class = header_with_cover_art-primary_info-primary_artist]").inner_text
    song_name = parsed_html.css("[class = header_with_cover_art-primary_info_container]").xpath("//h1").inner_text
    result = {:artist_name => artist_name, :song_name => song_name, :lyrics => lyrics}
    return result
end


# This method take in a genre name and links associated to that genre
# then it populates the database
def populate_genre(genre_name, genre_links)
    genre = Genre.find_or_create_by(name: genre_name)
    genre_links.each do |link|
        info = extract_song_info(link)
        artist = Artist.find_or_create_by(name: info[:artist_name])
        song = Song.find_or_create_by(title: info[:song_name])
        song.artist = artist
        song.lyrics = info[:lyrics].to_s
        song.save
        GenreSong.find_or_create_by(song_id: song.id ,genre_id: genre.id)
  end
end

# Not needed but it starts the seeding process
def seed(genres)
    starting = Time.now
    puts "Begining seeding process at #{starting}"
    genres.each do |key, val|
        genre_start = Time.now
        print "Populating : #{key}"
        populate_genre(key, find_links(val))
        genre_end = Time.now
        puts " (took #{genre_end - genre_start} seconds)" 
    end
    ending = Time.now
    elapsed = ending - starting
    puts "Seeding Complete at #{ending}! It took #{elapsed} seconds"
end

seed(all_genres)





