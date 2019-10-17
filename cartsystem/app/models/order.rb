class Order < ApplicationRecord
    validates_presence_of :address, :cart_id, :delivered
    
    has_one :cart
    has_many :order_delivery

    geocoded_by :address
    after_validation :geocode, :if => :address_changed?
end
