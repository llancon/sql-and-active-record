class Item < ApplicationRecord
  has_many :orders
  def total_order
    orders.sum(:quantity)
  end
end
