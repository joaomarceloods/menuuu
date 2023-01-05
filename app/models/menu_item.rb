class MenuItem < ApplicationRecord
  # TODO: test that it fails with a different user's menu
  belongs_to :menu, -> { where(business_id: Current.user.business.id) }
end
