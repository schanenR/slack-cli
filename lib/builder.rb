require 'httparty'
require 'dotenv'



class Builder

  class SlackAPIError < StandardError; end

  def initialize

    @id = nil
    @name = nil

  end

  def self.get(url, parameters)
    response = HTTParty.get(url, query: parameters)

    raise SlackAPIError, "API call failed - error: #{response["error"]}" if !response["ok"] && !response["error"].nil?

    return response
  end



end