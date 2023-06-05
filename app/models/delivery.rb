class Delivery < ApplicationRecord
  belongs_to :order

  with_options presence: true do
    validates :postalcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Input correctly"}
    validates :shipcity
    validates :shipaddress
    validates :phone_number, format: {with: /\A\d{10,11}\z/ , message: "Input only number"}
  end
  validates :shiparea_id, numericality: { other_than: 1, message: "can't be blank" }

end
