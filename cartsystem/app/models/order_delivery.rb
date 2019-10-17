class OrderDelivery < ApplicationRecord
    validates_presence_of :order_id, :address

    belongs_to :order

    geocoded_by :address
    after_validation :geocode, :if => :address_changed?

    # true if order has been delivered to dest, false otherwise
    def order_delivered?
        the_order = Order.find_by_id(self.order_id)
        return true if the_order.nil?
        the_order.delivered
    end

    # true if this node is the order dest, false otherwise
    def final_point?
        if latitude.nil? || longitude.nil?
            return self.address == order.address
        end

        self.latitude.round(4) == order.latitude.round(4) && self.longitude.round(4) == order.longitude.round(4)
    end

    def finish_delivery
        order.deliver
    end
end
