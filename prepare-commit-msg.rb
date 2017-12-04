#!/usr/bin/env ruby

require 'fileutils'

def read_stdin
  open '/dev/tty' do |f|
    input = f.gets.chomp
    yield input
  end
end

def save_issue(number)
  File.write '.git/ISSUE', number
  branch = File.read('.git/HEAD').match /^ref: refs\/heads\/(.+)/
  FileUtils.mkdir_p '.git/refs/issues'
  File.write ".git/refs/issues/#{branch[1]}", number if branch
end

def cache_issue(number, force: false)
  if !force && File.exists?('.git/ISSUE')
    return if number.to_s == File.read('.git/ISSUE')

    puts "Do you want to update issue in branch? (yes/anything else)"

    read_stdin do |input|
      save_issue number && return if input.downcase == 'yes'
    end
  end

  save_issue number
end

ISSUE_PATTERN = /^\[#(\d+)\]/

msg = File.read(ARGV[0])

issue_match = msg.match ISSUE_PATTERN
unless issue_match.nil?
  cache_issue issue_match[1]
  exit 0
end

issue = File.read('.git/ISSUE') if File.exists? '.git/ISSUE'

File.write(ARGV[0], "[##{issue}] #{msg}") && exit(0) unless issue.nil?

puts "Do you want to specify issue? Enter a number if yes or anything else if no."

# Have no idea why STDIN.reopen is not working
read_stdin do |input|
  if input.match? /^\d+$/
    File.write ARGV[0], "[##{input}] #{msg}"
    cache_issue input, force: true
  end
end

exit 0
