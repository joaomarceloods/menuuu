class MenuItem < ApplicationRecord
  belongs_to :menu

  validates :name, presence: true

  validates :price, presence: true

  validates :price,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 999_999.99
    }, if: :price?
end
