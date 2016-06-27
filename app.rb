#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop29.db"

class Client < ActiveRecord::Base
  validates :name, presence: true
  validates :phone, presence: true
  validates :datestamp, presence: true
  validates :color, presence: true


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
  # lamer way
  # @clients  = params['username']
  # @phone    = params['phone']
  # @datestamp= params['datetime']
  # @barber   = params['barber']
  # @color    = params['color']
  #
  # Client.create ({name: @clients, phone: @phone, datestamp: @datestamp, color: @color, barber: @barber})

  # advanced way
  c = Client.new params[:client]
  if c.save
    erb "<h2> спасибо вы записались</h2>"
  else
    erb "<h2>ошибка</h2>"
  end
end