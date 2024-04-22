class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one :order, dependent: :destroy
  has_one_attached :image

  validates :image, presence: true
  validates :name, :description, presence: true
  validates :category_id, :condition_id, :shipping_cost_burden_id, :prefecture_id,
            :shipping_duration_id, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :category_id, :condition_id, :shipping_cost_burden_id, :prefecture_id, :shipping_duration_id,
            numericality: { other_than: 1 }

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost_burden
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_duration
end
