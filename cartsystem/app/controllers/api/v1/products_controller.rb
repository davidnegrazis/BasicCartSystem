module Api
  module V1  # version 1 of API
    class ProductsController < ApplicationController
      def index
        products = Product.where("inventory_count > ?", 0) if params[:available].to_i == 1
        products ||= Product.order('id ASC')  # default

        render json: {
          status: 'SUCCESS',
          message: 'Loaded products',
          data: products
        },
        status: :ok
      end

      def show
        render json: {
          status: 'SUCCESS',
          message: 'Loaded product',
          data: product
        },
        status: :ok
      end

      def purchase
        n = params[:amount] == nil ? 1 : params[:amount].to_i

        if product.can_purchase?(n)
          product.purchase(n)
          
          render json: {
            status: 'SUCCESS',
            message: 'Purchased product',
            data: product
          },
          status: :ok
        else
          render json: {
            status: 'ERROR',
            message: "Could not purchase #{n} of product",
            data: product
          },
          status: :unprocessable_entity
        end
      end

      private

      def product
        @product ||= Product.find(params[:id])
      end
    end
  end
end
