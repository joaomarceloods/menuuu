class Menu < ApplicationRecord
  belongs_to :business

  has_many :menu_sections, dependent: :destroy

  has_many :publicly_visible_menu_sections,
            -> { where.not("TRIM(name) = ''") },
            class_name: "MenuSection"

  validates :name, presence: true
end
