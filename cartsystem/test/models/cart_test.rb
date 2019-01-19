require 'minitest/autorun'

class CartTest < MiniTest::Unit::TestCase
  def test_is_empty
    cart = Cart.new

    assert cart.empty?
  end
end
