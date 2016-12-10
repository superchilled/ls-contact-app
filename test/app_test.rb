# app_test.rb

ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use!
require "rack/test"
require "fileutils"

require_relative "../app.rb"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    # setup goes here
  end

  def teardown
    # teardown goes here
  end

  def test_index
    get "/"

    assert_equal 200, last_response.status
    assert last_response.body.include?("<h1>Hello World!")
    assert last_response.body.include?("<p>Welcome to Sinatra Boilerplate!</p>")
  end
end