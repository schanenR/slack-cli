require 'dotenv'

require_relative 'builder'

SLACK_URL = "https://slack.com/api/users.list"

class User < Builder

  def initialize

    @real_name = nil
    super
  end

end
