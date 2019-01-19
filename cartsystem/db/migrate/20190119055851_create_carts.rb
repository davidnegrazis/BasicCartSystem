class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.boolean :completed, default: false
      t.decimal :total, precision: 10, scale: 2, default: 0.00

      t.timestamps
    end
  end
end
