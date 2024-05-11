class Menu < ApplicationRecord
  belongs_to :business

  has_many :menu_sections, dependent: :destroy
  has_many :menu_items, through: :menu_sections

  has_many :publicly_visible_menu_sections,
            -> { where.not("TRIM(name) = ''") },
            class_name: MenuSection.name

  validates :name, presence: true

  delegate :subscribed?, to: :business, allow_nil: true
end
