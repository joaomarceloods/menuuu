class Subscription < ApplicationRecord
  # business can be null because subscription is created before business_id is known - see webhooks_controller.rb
  belongs_to :business, optional: true

  def subscribed?
    expired_at&.future?
  end
end
