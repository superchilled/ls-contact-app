# app.rb

require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

get '/' do
  @title = 'Hello World!'
  @content = 'Welcome to Sinatra Boilerplate!'

  erb :index
end
