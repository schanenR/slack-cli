
require_relative 'builder'

SLACK_URL = "https://slack.com/api/users.list"

class User < Builder

  attr_reader :real_name

  def initialize(id:, name:, real_name: )

    super(id: id, name: name)
    @real_name = real_name

  end

end
