class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :building, :prefecture_id, :city, :address, :phone_number, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' },
                             length: { in: 10..11, too_short: 'is too short', too_long: 'is too long' }
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create!(user_id:, item_id:)
      Address.create!(
        order_id: order.id,
        postal_code:,
        prefecture_id:,
        city:,
        address:,
        phone_number:,
        building:
      )
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
