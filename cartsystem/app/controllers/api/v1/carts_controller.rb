module Api
  module V1  # version 1 of API
    class CartsController < ApplicationController
      def index
        carts = Cart.order('id ASC')  # default

        render json: {
          message: 'Loaded carts',
          data: carts
        },
        status: :ok
      end

      def show
        info = cart.info
        render json: {
          message: 'Loaded cart',
          data: info
        },
        status: :ok
      end

      def create
        cart = Cart.new

        if cart.save
          render json: {
            message: 'Created cart',
            data: cart
          },
          status: :ok
        else
          render json: {
            message: 'Cart was not created',
            data: cart.errors
          },
          status: :unprocessable_entity
        end
      end

      def add
        quanity = params[:quantity] == nil ? 1 : params[:quantity].to_i

        if quanity > 0 && cart.add(params[:product_id], quanity)
          cart.update_columns(total: cart.total_price)

          render json: {
            message: 'Added item to cart',
            data: cart
          },
          status: :ok
        else
          render json: {
            message: "Could not add #{quanity} of product with id #{params[:product_id]} to cart",
            data: cart
          },
          status: :unprocessable_entity
        end
      end

      def complete
        if cart.complete
          render json: {
            message: 'Completed',
            data: cart
          },
          status: :ok
        else
          render json: {
            message: "Could not complete cart; it is either completed or has an invalid number of items",
            data: cart
          },
          status: :unprocessable_entity
        end
      end

      private

      def cart
        @cart ||= Cart.find(params[:id])
      end
    end
  end
end
