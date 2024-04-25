class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :building, :prefecture_id, :city, :address, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
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
        phone_number:
      )
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
