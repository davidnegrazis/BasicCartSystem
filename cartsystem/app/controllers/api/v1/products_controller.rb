module Api
  module V1  # version 1 of API
    class ProductsController < ApplicationController
      def index
        products = Product.where("inventory_count > ?", 0) if params[:available].to_i == 1
        products ||= Product.order('id ASC')  # default

        render json: products, status: :ok
      end

      def show
        render json: product, status: :ok
      end

      def purchase
        n = params[:amount] == nil ? 1 : params[:amount].to_i

        if product.can_purchase?(n)
          product.purchase(n)

          render json: product, status: :ok
        else
          render json: product, status: :bad_request
        end
      end

      private

      def product
        @product ||= Product.find(params[:id])
      end
    end
  end
end
