
require_relative 'user'
require_relative 'channel'

class Workspace
  class MessageError < StandardError; end

  attr_reader :users, :channels, :current_selection

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @current_selection = nil
  end

  def select_attribute(identifier)
    if identifier[0] == "U"
      @current_selection = users.find { |user| user.id == identifier }
    elsif identifier[0] == "C"
      @current_selection = channels.find { |channel| channel.id == identifier }
    else
      @current_selection = search_names(identifier)
    end
    if current_selection.nil?
      raise ArgumentError, "Search unsuccesful"
    end

    return "Selected #{current_selection.class}: #{current_selection.name}"
  end

  def show_details
    return current_selection.details
  end

  def send_message(message)
    raise ArgumentError, "Message must have at least one character" if message.length == 0

    response = current_selection.send_message(message)

    if response["ok"]
      return "Message sent to #{current_selection.class}: #{current_selection.name}"
    else
      raise MessageError, "Something went wrong - message not sent"
    end
  end

  private
  def search_names(name)
    selection = []
    selection << users.find { |user| user.name == name }
    selection << channels.find { |channel| channel.name == name }

    if selection.first.nil? && selection.last.nil?
      return nil
    elsif selection.first.nil?
      return selection.last
    elsif selection.last.nil?
      return selection.first
    else
      raise ArgumentError, "Multiple matching names"
    end
  end


end