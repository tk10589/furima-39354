class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string  :postalcode, null: false
      t.integer :shiparea_id, null: false
      t.string :shipcity, null: false
      t.string :shipaddress, null: false
      t.string :apartment, null: false
      t.string :phone_number, null: false
      t.references :order, null: false, foreign_key: true
      t.timestamps
    end
  end
end
