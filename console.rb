require 'pry'
require 'open-uri'
require 'nokogiri'
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

binding.pry
find_links(country_page)
