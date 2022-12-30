class Menu < ApplicationRecord
  belongs_to :business

  has_many :menu_items

  validates :name, presence: true
end
