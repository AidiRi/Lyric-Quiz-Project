require_relative 'config/environment.rb'
require "sinatra/activerecord/rake"

desc "start console"
task :console do
  Pry.start
end

desc "run the Lyrics Quiz"
task :run do
  cli = CLILyricsQuiz.new
  cli.run
end
