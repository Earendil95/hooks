#!/usr/bin/env ruby

require 'fileutils'

ISSUE_PATTERN = /^\[#\d+\]/

msg = File.read(ARGV[0])

exit(0) if msg.match? ISSUE_PATTERN

issue = File.read('.git/ISSUE') if File.exists? '.git/ISSUE'

File.write(ARGV[0], "[##{issue}] #{msg}") && exit(0) if !issue.nil?

puts "Do you want to specify issue? Enter a number if yes and anything else if no."

# Have no idea why STDIN.reopen is not working
open '/dev/tty' do |f|
  input = f.gets.chomp
  if input.match? /^\d+$/
    File.write ARGV[0], "[##{input}] #{msg}"
    File.write '.git/ISSUE', input
    m = File.read('.git/HEAD').match /^ref: refs\/heads\/(.+)/
    FileUtils.mkdir_p '.git/refs/issues'
    File.write ".git/refs/issues/#{m[1]}", input
  end
end

exit 0
