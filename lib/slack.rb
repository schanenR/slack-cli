#!/usr/bin/env ruby
#
require 'table_print'
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
  puts "#{workspace.users.count} Users loaded!"
  puts "#{workspace.channels.count} Channels loaded!"

  input = request_input
  input = validate_input(input)

  until input == "quit"
    if input == "list users"
      tp workspace.users, :name, :id, :real_name
    elsif input == "list channels"
      tp workspace.channels, :name, :id, :topic, :member_count
    elsif input == "select channel" || input == "select user"
      makes_selection(workspace)
    elsif input == "details"
      gets_details(workspace)
    elsif input == "send message"
      sending_message(workspace)
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

def sending_message(workspace)
  if workspace.current_selection.nil?
    puts "Sorry, a user or channel must be selected first"
  else
    puts "Please enter a message:"
    message = gets.chomp
    begin
      confirmation = workspace.send_message(message)
      puts confirmation
    rescue ArgumentError
      puts "Sorry, your message must have at least one character"
    rescue MessageError
      puts "Sorry, something went wrong - your message was not sent"
    end
  end
end

def gets_details(workspace)
  if workspace.current_selection.nil?
    puts "Sorry, a user or channel must be selected first"
  else
    puts workspace.show_details
  end
end

def makes_selection(workspace)
  puts "Please enter an ID or name:"
  identifier = gets.chomp
  begin
    response = workspace.select_attribute(identifier)
    puts response
  rescue ArgumentError
    puts "No user or channel found"
  end
end

main if __FILE__ == $PROGRAM_NAME
