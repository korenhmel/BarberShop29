#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop29.db"

class Client < ActiveRecord::Base
  validates :name, presence: true, length: {in: 3..20}
  validates :phone, presence: true, length: { minimum: 3 }
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

  @c = Client.new
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
  @c = Client.new params[:client]
  if @c.save
    erb "<h2> спасибо вы записались</h2>"
  else
    @error = @c.errors.full_messages.first
    erb :vizit
  end
end

get '/barber/:id' do
  erb :barber
end