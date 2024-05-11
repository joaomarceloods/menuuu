class MenuItem < ApplicationRecord
  # The scope validates that it belongs to the current user
  belongs_to :menu_section,
             -> { joins(menu: :business).where(business: { user_id: Current.user.id }) },
             touch: true

  delegate :menu, to: :menu_section
  delegate :business, to: :menu

  acts_as_list scope: :menu_section
end
