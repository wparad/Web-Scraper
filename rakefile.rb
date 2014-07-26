#!/usr/bin/ruby

require 'rake'
require 'rake/clean'

task :run_server do
  puts "Running the gem server, so you can get help on selenium @ http://localhost:8808/"
  cmd = "run server"
  %x[#{cmd}]
end
