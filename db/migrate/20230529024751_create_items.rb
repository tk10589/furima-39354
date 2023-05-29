class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string  :item
      t.text    :item_description
      t.integer :category_id
      t.integer :item_condition_id
      t.integer :shipbase_id
      t.integer :shiparea_id
      t.integer :shipdate_id
      t.integer :price
      t.text    :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
