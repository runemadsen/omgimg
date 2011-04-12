require 'rubygems'
require 'bundler'
Bundler.require
require 'models'

enable :sessions
mime_type :ttf, 'font/ttf'
mime_type :woff, 'font/woff'

get '/' do
  erb :login
end

post '/users/new' do
  session[:user] = User.find_or_create_by_name(params[:name])
  redirect '/today'
end

get '/today/?' do
  erb :today
end

