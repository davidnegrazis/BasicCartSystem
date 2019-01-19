require 'minitest/autorun'

class ProductTest < MiniTest::Unit::TestCase
  def test_can_purchase
    initial_count = 2
    p = Product.new({title: "title", price: 20, inventory_count: initial_count})
    assert p.can_purchase?(0)
    assert p.can_purchase?(initial_count - 1)
    assert p.can_purchase?(initial_count)
    refute p.can_purchase?(initial_count + 1)
  end
end
