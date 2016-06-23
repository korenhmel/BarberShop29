#encoding: utf-8
require 'rubygems'
require 'sinatra'
 require 'sinatra/reloader'
 require 'sinatra/activerecord'

set :database, "sqlite3:barbershop29.db"

class Client < ActiveRecord::Base

end
class Barber < ActiveRecord::Base

end
get '/' do
  @barbers = Barber.order "created_at DESC"
	erb :index
end

get '/vizit' do

  erb :vizit
end

post '/vizit' do
  @clients  = params['username']
  @phone    = params['phone']
  @datestamp= params['datetime']
  Client.create ({name: @clients, phone: @phone, datestamp: @datestamp})
  erb :vizit
end