class CreateOrderDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :order_deliveries do |t|
      t.text :address
      t.float :latitude
      t.float :longitude
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
