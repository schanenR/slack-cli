require 'httparty'
require 'dotenv'

Dotenv.load



class Builder

  class SlackAPIError < StandardError; end

  attr_reader :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  def self.get(url, parameters)

    sleep(2)
    response = HTTParty.get(url, query: parameters)

    raise SlackAPIError, "API call failed - error: #{response["error"]}" if !response["ok"] && !response["error"].nil?

    return response
  end

  def self.details

    raise NotImplementedError, "Implement in child class"
  end

  def self.list_all

    raise NotImplementedError, "Implement in child class"
  end

  def send_message(message)
    url = "https://slack.com/api/chat.postMessage"
    query = {
        token: ENV["SLACK_TOKEN"],
        channel: self.id,
        text: message
    }

    sleep(2)

    response = HTTParty.post(url, query: query)

    unless response["ok"]
      raise SlackAPIError, "Send message failed, error: #{response["error"]}"
    end

    return response
  end


end