#!/usr/bin/env ruby
require_relative 'workspace'


def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  list_options = user_options

  until list_options == "quit"
    if list_options == "list users"
      puts workspace.users
      list_options = user_options
    elsif list_options == "list channels"
      puts workspace.channels
      list_options = user_options
    else
      list_options = user_options
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

def user_options
  puts "Which action would you like to take in our Slack Workspace?"
  puts "list users"
  puts "list channels"
  puts "quit"
  return gets.chomp.downcase
end

main if __FILE__ == $PROGRAM_NAME
