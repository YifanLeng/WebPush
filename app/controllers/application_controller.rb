# require all the active record models
# require_all 'app/models'
require './config/environment'
require 'redis'
require 'json'

# the root route
class ApplicationController < Sinatra::Base

	configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :server, :puma
    # create namespace for caching notifications
    set :redis, Redis.new
    enable :sessions
    register Sinatra::Flash
  end

  get '/notifications/:fan_id' do
    fan_id = params[:fan_id]
    key = "notifs:#{fan_id}"
    stars = settings.redis.get(key)
    return stars.to_json
  end

  post '/notifications' do 
    star_id = params[:star]
    fan_id = params[:fan]
    key = "notifs:#{fan_id}"
    value = settings.redis.get(key)
    if value == nil
      settings.redis.set(key, [star_id])
    else
      value = JSON.parse(value) << star_id
      settings.redis.set(key, value)
    end
    status 200
  end

end