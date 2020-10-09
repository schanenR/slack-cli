
require_relative 'builder'

SLACK_URL = "https://slack.com/api/users.list"

class User < Builder

  attr_reader :real_name

  def initialize(id:, name:, real_name: )

    super(id: id, name: name)
    @real_name = real_name

  end

  def details
    return "\n  ID: #{id}\n  Username: #{name}\n  Real Name: #{real_name}"
  end

  def self.list_all
    parameters = {token: ENV["SLACK_TOKEN"]}
    response = self.get(SLACK_URL, parameters)

    response["members"].map do |user|
      new(
          id: user["id"],
          name: user["name"],
          real_name: user["profile"]["real_name"]
      )
    end
  end

end
