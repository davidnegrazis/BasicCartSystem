require 'minitest/autorun'
require 'rest-client'
require 'json'

class ProductsAPITest < MiniTest::Unit::TestCase
  def setup
  end

  def test_get_works
    response = RestClient.get('http://localhost:3000/api/v1/products')
    data = JSON.parse(response.body)

    assert_equal 'SUCCESS', data['status']
  end

  def test_get_only_available
    valid = true
    response = RestClient.get('http://localhost:3000/api/v1/products?available=1')
    data = JSON.parse(response.body)

    # check if any returned products have 0 inventory_count, which is bad
    data['data'].each do |prod|
      if prod['inventory_count'] == 0
        valid = false
        break
      end
    end

    assert valid
  end
end
