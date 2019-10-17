class Order < ApplicationRecord
    validates_presence_of :address, :cart_id

    belongs_to :cart
    has_many :order_deliveries

    geocoded_by :address
    after_validation :geocode, :if => :address_changed?

    # returns delivery progress with distance to go per node in km
    def delivery_nodes
        nodes = []
        order_deliveries.collect do |node|
            nodes << {
                'latitude' => node.latitude,
                'longitude' => node.longitude,
                'time' => node.created_at,
                'distance_to_go' => Geocoder::Calculations.distance_between([latitude, longitude], [node.latitude, node.longitude], units: :km)
            }
        end

        nodes
    end

    # set delivered to true
    def deliver
        self.update_columns(delivered: true)
    end

    # we use this to make sure we're only ordering a purchased cart
    def can_order_cart?
        return false if cart_id.nil?
        the_cart = Cart.find_by_id(self.cart_id)
        return false if the_cart.nil?
        return the_cart.completed
    end
end
