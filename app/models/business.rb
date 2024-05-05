class Business < ApplicationRecord
  belongs_to :user

  has_one :subscription, dependent: :destroy
  has_many :menus, dependent: :destroy

  validates :name, presence: true

  delegate :subscribed?, to: :subscription, allow_nil: true
end
