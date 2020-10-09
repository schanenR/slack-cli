require_relative 'builder'



class Channel < Builder

  SLACK_URL = "https://slack.com/api/conversations.list"

  attr_reader :topic, :member_count

  def initialize(id:, name:, topic:, member_count:)

    super(id: id, name: name)
    @topic = topic
    @member_count = member_count

  end

  def details
    return "ID: #{id}\nName: #{name}\nTopic:#{topic}\nNumber of Members: #{member_count}"
  end

  def self.list_all
    parameters = {token: ENV["SLACK_TOKEN"]}
    response = self.get(SLACK_URL, parameters)

    response["channels"].map do |channel|
      new(
          id: channel["id"],
          name: channel["name"],
          topic: channel["topic"]["value"],
          member_count: channel["num_members"]
      )
    end
  end
end