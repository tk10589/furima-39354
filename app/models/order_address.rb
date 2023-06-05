class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postalcode, :shiparea_id, :shipcity, :shipaddress, :apartment, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postalcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Input correctly"}
    validates :shipcity
    validates :shipaddress
    validates :phone_number, format: {with: /\A\d{10,11}\z/ , message: "Input only number"}
  end
  validates :shiparea_id, numericality: { other_than: 1 , message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivery.create(postalcode: postalcode, shiparea_id: shiparea_id, shipcity: shipcity, shipaddress: shipaddress, apartment: apartment, phone_number: phone_number, order_id: order.id)
  end
end