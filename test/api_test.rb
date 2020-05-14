require "net/http"
require "uri"


3.times do
  uri = URI.parse("http://0.0.0.0:3000/notifications")
  response = Net::HTTP.post_form(uri, 
    {"fan" => "1", "star" => "2"})
end