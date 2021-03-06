module Api
    module V1  # version 1 of API
        class OrdersController < ApplicationController
            before_action :set_order, only: [:show, :update, :destroy, :nodes]

            # GET /orders
            def index
                @orders = Order.all

                render json: @orders, status: :ok
            end

            # GET /orders/1
            def show
                render json: @order, status: :ok
            end

            # POST /orders
            def create
                @order = Order.new(order_params)

                if !@order.can_order_cart?
                    render json: {
                        'alert': 'Cart has not been purchased yet or cart does not exist'
                    }, status: :bad_request

                    return
                end

                if @order.save
                    render json: @order, status: :created
                else
                    render json: @order.errors, status: :unprocessable_entity
                end
            end

            def update
                if @order.update(order_params)
                    render json: @order
                else
                    render json: @order.errors, status: :unprocessable_entity
                end
            end

            def destroy
                @order.destroy
            end

            def nodes
                render json: @order.delivery_nodes, status: :ok
            end

            private
            # Use callbacks to share common setup or constraints between actions.
            def set_order
                @order = Order.find(params[:id])
            end

            # Only allow a trusted parameter "white list" through.
            def order_params
                params.require(:order).permit(:address, :cart_id, :latitude, :longitude)
            end
        end
    end
end
