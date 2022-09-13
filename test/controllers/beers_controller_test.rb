require_relative "../test_helper"
require_relative "../../spec/spec_helper"
require_relative "../../spec/rails_helper"
class BeersControllerTest < ActionDispatch::IntegrationTest

  # Was the web request successful?
  test "should respond with info about beer id" do
    get "/beers/2"
    assert_response :success
  end

  # Was the correct response given?
  test "should get all beers" do
    get "/beers"
    print(response.body)
    assert_response :success
    expect(JSON.parse(response.body)).to equal()
  end
end
