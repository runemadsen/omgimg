require 'rubygems'
require 'bundler'
Bundler.require
require 'models'

mime_type :ttf, 'font/ttf'
mime_type :woff, 'font/woff'

get '/' do
  erb :login
end

