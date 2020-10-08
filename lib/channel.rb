require_relative 'builder'



class Channel < Builder

  attr_reader :topic, :member_count

  def initialize(id:, name:, topic:, member_count:)

    super(id: id, name: name)
    @topic = topic
    @member_count = member_count

  end
end