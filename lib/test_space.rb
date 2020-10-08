
require_relative 'user'


sample_user = User.new(id: "U017ARD8DBM", name: "genevieve.hood", real_name: "Genevieve Neely")

response = sample_user.send_message("heloooo")

p response

p response["ok"]