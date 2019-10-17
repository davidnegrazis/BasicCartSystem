require 'minitest/autorun'
require 'rest-client'
require 'json'

class OrderDeliveriesAPITest < MiniTest::Unit::TestCase
  def setup
  end

  def test_get_works
    response = RestClient.get('http://localhost:3000/api/v1/order_deliveries')

    assert_equal response.code, 200
  end
end
