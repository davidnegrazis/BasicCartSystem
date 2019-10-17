module Api
  module V1  # version 1 of API
    class CartsController < ApplicationController
      def index
        carts = Cart.order('id ASC')  # default

        render json: carts, status: :ok
      end

      def show
        info = cart.info
        render json: info, status: :ok
      end

      def create
        cart = Cart.new

        if cart.save
          render json: cart, status: :ok
        else
          render json: cart.errors, status: :bad_request
        end
      end

      def add
        quantity = params[:quantity] == nil ? 1 : params[:quantity].to_i

        if quantity > 0 && cart.add(params[:product_id], quantity)
          cart.update_columns(total: cart.total_price)

          render json: cart, status: :ok
        else
          render json: cart, status: :bad_request
        end
      end

      def complete
        if cart.complete
          render json: cart, status: :ok
        else
          render json: cart, status: :bad_request
        end
      end

      private

      def cart
        @cart ||= Cart.find(params[:id])
      end
    end
  end
end
