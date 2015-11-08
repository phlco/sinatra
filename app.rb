require 'sinatra' # load up our sinatra library
require "httparty" # this library let's my server make requests like a client

# this code has to be added to work with nitrous.io
configure :development do
  set :bind, '0.0.0.0'
  set :port, 3000 # Not really needed, but works well with the "Preview" menu option
end

# do this code when the client requests "/"
get('/') do
  ip_address = request.ip
  ip_address_lookup_url = "http://ip-api.com/json/#{ip_address}"
  res = HTTParty.get(ip_address_lookup_url)
  city = res["city"]
  api_key = "2de143494c0b295cca9337e1e96b00e0"
  ## next step is looking up weather
  weather_url = "http://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{api_key}&units=imperial"
  res = HTTParty.get(weather_url)
  temp = res["main"]["temp"]
  iced_coffee_temp = 50
  if (temp < iced_coffee_temp)
    "<h1>NO</h1>"
  else
    "<h1>YES</h1>"
  end
end


