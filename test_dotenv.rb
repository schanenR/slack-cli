require 'httparty'
require 'dotenv'
Dotenv.load

url = 'https://slack.com/api/conversations.list'

response = HTTParty.get(url, query: {
    token: ENV['SLACK_TOKEN']
})

if response['ok']
  puts "Eventhing worked according to plan!"
else
  puts "Something went wrong :("
end