class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :delivery
  has_one :card

end
