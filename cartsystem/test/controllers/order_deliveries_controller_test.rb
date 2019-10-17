require 'test_helper'

class OrderDeliveriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_delivery = order_deliveries(:one)
  end

  test "should get index" do
    get order_deliveries_url, as: :json
    assert_response :success
  end

  test "should create order_delivery" do
    assert_difference('OrderDelivery.count') do
      post order_deliveries_url, params: { order_delivery: { address: @order_delivery.address, latitude: @order_delivery.latitude, longitude: @order_delivery.longitude } }, as: :json
    end

    assert_response 201
  end

  test "should show order_delivery" do
    get order_delivery_url(@order_delivery), as: :json
    assert_response :success
  end

  test "should update order_delivery" do
    patch order_delivery_url(@order_delivery), params: { order_delivery: { address: @order_delivery.address, latitude: @order_delivery.latitude, longitude: @order_delivery.longitude } }, as: :json
    assert_response 200
  end

  test "should destroy order_delivery" do
    assert_difference('OrderDelivery.count', -1) do
      delete order_delivery_url(@order_delivery), as: :json
    end

    assert_response 204
  end
end
