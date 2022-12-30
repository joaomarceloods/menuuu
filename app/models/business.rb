class Business < ApplicationRecord
  belongs_to :user

  has_many :menus

  validates :name, presence: true
end
