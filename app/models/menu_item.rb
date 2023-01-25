class MenuItem < ApplicationRecord
  acts_as_list

  # TODO: test that it fails with a different user's menu
  # TODO: replace this scope by an authorization library
  belongs_to :menu, -> { where(business_id: Current.user.business.id) }
end
