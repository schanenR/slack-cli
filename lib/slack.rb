#!/usr/bin/env ruby
require_relative 'workspace'

VALID_ACTIONS = [
    "list users",
    "list channels",
    "select user",
    "select channel",
    "details",
    "send message",
    "quit"
].freeze

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  input = request_input
  input = validate_input(input)

  until input == "quit"
    if input == "list users"
      puts "printing users"
    elsif input == "list channels"
      puts "printing channels"
    elsif input == "select channel" || input == "select user"
      puts "Please enter an ID or name:"
      identifier = gets.chomp
      response = workspace.select_attribute(identifier)
      puts response
    elsif input == "details"
      if workspace.current_selection.nil?
        puts "Sorry, a user or channel must be selected first"
      else
        puts workspace.show_details
      end
    elsif input == "send message"
      if workspace.current_selection.nil?
        puts "Sorry, a user or channel must be selected first"
      else
        puts "Please enter a message:"
        message = gets.chomp
        confirmation = workspace.send_message(message)
        puts confirmation
      end
    end
    input = request_input
  end



  puts "Thank you for using the Ada Slack CLI"
end

def request_input
  puts "Please select an action:"
  VALID_ACTIONS.each_with_index do |action, index|
    puts "#{index + 1}. #{action}"
  end

  selection = gets.chomp.downcase
  validate_input(selection)
end

def validate_input(input)
  until VALID_ACTIONS.include?(input)
    puts "Sorry, that's not a valid selection"
    input = request_input
    validate_input(input)
  end
  return input
end


main if __FILE__ == $PROGRAM_NAME
