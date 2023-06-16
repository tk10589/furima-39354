class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :item_condition
  belongs_to :shipbase
  belongs_to :shiparea
  belongs_to :shipdate

  has_one_attached :image
  has_one :order

  validates :item_name, presence: true, length: { maximum: 40 }
  validates :item_description, presence: true, length: { maximum: 1000 }
  validates :category_id, numericality: { other_than: 1 }
  validates :item_condition_id, numericality: { other_than: 1 }
  validates :shipbase_id, numericality: { other_than: 1 }
  validates :shiparea_id, numericality: { other_than: 1 }
  validates :shipdate_id, numericality: { other_than: 1 }
  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end
  validates :image, presence: true
end
