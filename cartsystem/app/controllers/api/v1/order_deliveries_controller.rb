module Api
    module V1  # version 1 of API
        class OrderDeliveriesController < ApplicationController
            before_action :set_order_delivery, only: [:show, :update, :destroy]

            # GET /order_deliveries
            def index
                @order_deliveries = OrderDelivery.all

                render json: @order_deliveries
            end

            # GET /order_deliveries/1
            def show
                render json: @order_delivery
            end

            # POST /order_deliveries
            def create
                @order_delivery = OrderDelivery.new(order_delivery_params)
                if @order_delivery.order_delivered?
                    render json: {
                        'alert': 'Order has already been delivered or order does not exist'
                    }, status: :bad_request

                    return
                end

                if @order_delivery.save
                    if @order_delivery.final_point?
                        @order_delivery.finish_delivery
                    end

                    render json: @order_delivery, status: :created
                else
                    render json: @order_delivery.errors, status: :unprocessable_entity
                end
            end

            # PATCH/PUT /order_deliveries/1
            def update
                if @order_delivery.update(order_delivery_params)
                    render json: @order_delivery
                else
                    render json: @order_delivery.errors, status: :unprocessable_entity
                end
            end

            # DELETE /order_deliveries/1
            def destroy
                @order_delivery.destroy
            end

            private
            # Use callbacks to share common setup or constraints between actions.
            def set_order_delivery
                @order_delivery = OrderDelivery.find(params[:id])
            end

            # Only allow a trusted parameter "white list" through.
            def order_delivery_params
                params.require(:order_delivery).permit(:address, :latitude, :longitude, :order_id)
            end
        end
    end
end
