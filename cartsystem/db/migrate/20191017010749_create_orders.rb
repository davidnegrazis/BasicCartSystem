class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.text :address
      t.float :latitude
      t.float :longitude
      t.boolean :delivered, default: false
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end
