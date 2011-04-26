require 'rubygems'
require 'bundler'
Bundler.require
require 'net/http'
require 'partials'
require 'models'

helpers Sinatra::Partials

GoogleAjax.referrer = "http://www.runemadsen.com"

mime_type :ttf, 'font/ttf'
mime_type :woff, 'font/woff'

enable :sessions

before do
  ActiveRecord::Base.verify_active_connections!
end

get '/' do
  erb :login
end

post '/users/new' do
  session[:user_id] = User.find_or_create_by_name(params[:name]).id
  redirect '/today'
end

get '/today/?' do
  redirect "/" if session[:user_id].nil?
  @discussion = Discussion.where(:date => Date.today).first || Discussion.last
  erb :today
end

get '/archive/?' do
  redirect "/" if session[:user_id].nil?
  @discussions = Discussion.all
  erb :archive
end

get '/archive/:date/?' do
  redirect "/" if session[:user_id].nil?
  @discussion = Discussion.where(:date => params[:date]).first || Discussion.last
  erb :today
end

get '/search/:q' do
  @result = GoogleAjax::Search.images(params[:q], {:v => 1.0, :imgsz => "small|medium", :rsz => 8})
  erb :search, :layout => false
end

get '/new/?' do
  redirect "/" if session[:user_id].nil?
  @date = Discussion.order("date DESC").first.date + 1
  @date = Date.today if @date < Date.today
  erb :new_discussion
end

post '/new/?' do
  redirect "/" if session[:user_id].nil?
  if params[:password] == "omgthisissecret"
    @date = Discussion.order("date DESC").first.date + 1
    @date = Date.today if @date < Date.today
    d = Discussion.create(:date => @date)
    d.image = Image.create(:url => params[:url], :user_id => session[:user_id], :searchterm => "Discussion image")
    "Yeah, saved!"
  else
    "Wrong password"
  end
end

post '/images' do
  begin
    parent = Image.find(params[:parent_id])
    parent.images.create(:url => params[:url], :user_id => session[:user_id], :searchterm => params[:searchterm])
    "OK"
  rescue Exception => e
    "Error"
  end
end

post '/images/:id/rating' do
    image = Image.find(params[:id])
    image.rating += 1
    image.save
    image.rating.to_s
end

