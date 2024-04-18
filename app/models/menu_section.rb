class MenuSection < ApplicationRecord
  # The scope validates that it belongs to the current user
  belongs_to :menu, -> {
    if Current.user.present?
      joins(:business).merge(Business.where(user: Current.user))
    end
  }, touch: true

  has_many :menu_items, dependent: :destroy

  has_many :publicly_visible_menu_items,
            -> { where.not("TRIM(name) = ''") },
            class_name: "MenuItem"

  acts_as_list scope: :menu
end
