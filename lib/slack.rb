#!/usr/bin/env ruby
#
require 'tabulo'
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

  tp.set :max_width, 120

  puts "\nWelcome to the Ada Slack CLI!\n"
  workspace = Workspace.new
  puts "\n#{workspace.users.count} Users loaded!"
  puts "#{workspace.channels.count} Channels loaded!"

  input = request_input
  input = validate_input(input)

  until input == "quit"
    if input == "list users"
      table = Tabulo::Table.new(workspace.users, title: "USER LIST")

      table.add_column("ID", &:id)
      table.add_column("NAME", &:name)
      table.add_column("REAL NAME", &:real_name)

      puts table.pack
    elsif input == "list channels"
      table = Tabulo::Table.new(workspace.channels, title: "CHANNEL LIST")

      table.add_column("ID", &:id)
      table.add_column("NAME", &:name)
      table.add_column("MEMBER COUNT", &:member_count)
      table.add_column("CHANNEL TOPIC", &:topic)

      table.pack(max_table_width: 80)
      puts table
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
  puts "\n  Please select an action:\n\n"
  VALID_ACTIONS.each_with_index do |action, index|
    puts "  #{index + 1}. #{action}"
  end
  print "\n===> "
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
  puts "\nPlease enter an ID or name:"
  print "\n===> "
  identifier = gets.chomp
  begin
    response = workspace.select_attribute(identifier)
    puts response
  rescue ArgumentError
    puts "No user or channel found"
  end
end

main if __FILE__ == $PROGRAM_NAME
