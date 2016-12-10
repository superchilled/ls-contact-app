# app.rb

require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'yaml'

before do
  @contacts = YAML.load_file('data/contacts.yaml')
end

get '/' do

  erb :index
end

get '/contact/:id' do
  @id = params['id'].to_sym
  @contact = @contacts[@id]

  erb :contact
end

get '/update/:id' do
  @id = params['id'].to_sym
  @contact = @contacts[@id]

  erb :update
end

post '/update/:id' do
  @id = params['id'].to_sym
  @contact = @contacts[@id]

  updated_details = {
    name: params['name'],
    tel: params['tel'],
    email: params['email'],
    address: {
      address_1: params['address_1'],
      address_2: params['address_2'],
      city: params['city'],
      region: params['region'],
      postcode: params['postcode'],
      country: params['country']
    }
  }

  updated_details.each do |k, v|
    if k == :address
      v.each do |addr_k, addr_v|
        @contact[:address][addr_k] = addr_v
      end
    else
      @contact[k] = v
    end
  end

  @contacts[@id] = @contact
  File.open("data/contacts.yaml", 'w') { |f| YAML.dump(@contacts, f) }

  redirect "/contact/#{@id}"
end

post '/delete/:id' do
  @id = params['id'].to_sym
  @contact = @contacts[@id]

  @contacts.delete(@id)
  File.open("data/contacts.yaml", 'w') { |f| YAML.dump(@contacts, f) }

  redirect '/'
end

get '/new' do
  erb :new
end

post '/new' do
  new_id = @contacts.keys.map(&:to_s).map(&:to_i).max + 1

  new_contact = {address: {}}

  contact_details = {
    name: params['name'],
    tel: params['tel'],
    email: params['email'],
    address: {
      address_1: params['address_1'],
      address_2: params['address_2'],
      city: params['city'],
      region: params['region'],
      postcode: params['postcode'],
      country: params['country']
    }
  }

    contact_details.each do |k, v|
    if k == :address
      v.each do |addr_k, addr_v|
        new_contact[:address][addr_k] = addr_v
      end
    else
      new_contact[k] = v
    end
  end

  @contacts[new_id.to_s.to_sym] = new_contact
  File.open("data/contacts.yaml", 'w') { |f| YAML.dump(@contacts, f) }

  redirect "/contact/#{new_id}"
end