class MenuItem < ApplicationRecord
  # The scope validates that it belongs to the current user
  belongs_to :menu_section, -> {
    if Current.user.present?
      joins(menu: :business).merge(Business.where(user: Current.user))
    end
  }, touch: true

  acts_as_list scope: :menu_section
end
