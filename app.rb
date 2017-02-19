# app.rb

require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require "easy_breadcrumbs"
require_relative 'db'

configure(:development) do
  require "sinatra/reloader"
  also_reload "db.rb"
end

before do
  @db = DatabaseConnection.new(logger)
end

helpers do
  def compact_address(contact)
    [
      contact[:address_1],
      contact[:address_2],
      contact[:city],
      contact[:region],
      contact[:postcode],
      contact[:country]
    ].compact.reject { |addr_line| addr_line == '' }
  end
end

get '/' do
  @contacts = @db.contact_list
  erb :index
end

get '/contact/:id' do
  id = params['id']
  @contact = @db.get_contact(id)
  @title = @contact[:name]

  erb :contact
end

get '/update/:id' do
  @id = params['id']
  @contact = @db.get_contact(@id)

  erb :update
end

post '/update/:id' do
  id = params['id']

  updated_details = {
    name: params['name'],
    tel: params['tel'],
    email: params['email'],
    address_1: params['address_1'],
    address_2: params['address_2'],
    city: params['city'],
    region: params['region'],
    postcode: params['postcode'],
    country: params['country']
  }

  @db.update_contact(id, updated_details)

  redirect "/contact/#{id}"
end

post '/delete/:id' do
  id = params['id']
  @db.delete_contact(id)

  redirect '/'
end

get '/new' do
  erb :new
end

post '/new' do
  contact_details = {
    name: params['name'],
    tel: params['tel'],
    email: params['email'],
    address_1: params['address_1'],
    address_2: params['address_2'],
    city: params['city'],
    region: params['region'],
    postcode: params['postcode'],
    country: params['country']
  }

  @db.create_contact(contact_details)

  redirect "/"
end