class Item < ApplicationRecord
  belongs_to :user

  validates :item, presence: true
  validates :item_description, presence: true
  validates :category_id, presence: true
  validates :item_condition_id, presence: true
  validates :shipbase_id, presence: true
  validates :shiparea_id, presence: true
  validates :shipdate_id, presence: true
  validates :price, presence: true
  validates :image, presence: true
  
end
