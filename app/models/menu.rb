class Menu < ApplicationRecord
  belongs_to :business

  has_many :menu_items

  has_many :publicly_visible_menu_items, -> {
    where.not(price: nil).
    where.not("TRIM(name) = ''")
  }, class_name: "MenuItem"

  validates :name, presence: true
end
