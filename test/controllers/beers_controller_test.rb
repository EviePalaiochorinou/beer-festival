require "test_helper"

class BeersControllerTest < ActionDispatch::IntegrationTest
  
  # Was the web request successful?
  test "should respond with info about beer id" do
    get "/beers/2"
    assert_response :success
  end
end
