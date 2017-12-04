#!/usr/bin/env ruby

heads = '.git/refs/heads/'
issues = '.git/refs/issues/'

branch = File.read('.git/HEAD').match /^ref: refs\/heads\/(.+)/

if File.exists?(issues + branch[1])
  issue = File.read issues + branch[1]
  puts "Current issue is ##{issue}"
  File.write '.git/ISSUE', issue
else
  puts "Current issue is not specified yet"
end

exit(0)
