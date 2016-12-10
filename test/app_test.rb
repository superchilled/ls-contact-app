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
    assert last_response.body.include?("<h1>Contacts</h1>")
    assert last_response.body.include?("Keri Silver")
  end

  def test_update_contact
    post "/update/2", {name: 'Molly Millions', tel: "00000000"}

    assert_equal 302, last_response.status
    get last_response["Location"]
    assert_includes last_response.body, "<td>00000000</td>"
  end
end