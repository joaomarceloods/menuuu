class Business < ApplicationRecord
  belongs_to :user

  has_many :menus, dependent: :destroy

  validates :name, presence: true
end
