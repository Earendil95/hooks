#!/usr/bin/env ruby

heads = '.git/refs/heads/'
issues = '.git/refs/issues/'

Dir.new(heads).each do |f|
  next if f.match? /^\.+$/ # skipping '.' and '..'

  # finding current branch name
  commit = File.read(heads + f).chomp
  next if commit != ARGV[1]

  if File.exists?(issues + f)
    issue = File.read issues + f
    puts "Current issue is ##{issue}"
    File.write '.git/ISSUE', issue
  else
    puts "Current issue is not specified yet"
  end
end

exit(0)
