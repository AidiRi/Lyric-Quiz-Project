require_relative 'config/environment.rb'
require_all "app/game"
require "sinatra/activerecord/rake"

desc "start console"
task :console do
  Pry.start
end

desc "Showing all Songs"
task :songs do
  puts Song.all
end

desc "run the Lyrics Quiz"
task :run do
  cli = CLILyricsQuiz.new
  cli.run
end
