require_relative "../test_helper"
require_relative "../../spec/rails_helper"
require_relative "../../spec/spec_helper"

class BeersControllerTest < ActionDispatch::IntegrationTest

  # Was the web request successful?
  test "should respond with info about beer id" do
    get "/beers/2"
    assert_response :success
  end

  test "should get all beers" do
    get "/beers"
    assert_response :success
  end

  test "should respond with info about beer with given name" do
    get "/beers?name=buzz"
    assert_response :success
  end
end
