require 'minitest/autorun'
require 'rest-client'
require 'json'

class CartsAPITest < MiniTest::Unit::TestCase
  def setup
  end

  def test_get_works
    response = RestClient.get('http://localhost:3000/api/v1/carts')
    data = JSON.parse(response.body)

    assert_equal 'SUCCESS', data['status']
  end
end
