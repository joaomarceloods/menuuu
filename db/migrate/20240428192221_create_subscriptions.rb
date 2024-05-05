class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      # business can be null because subscription is created before business_id is known - see webhooks_controller.rb
      t.references :business, null: true, foreign_key: true
      t.string :stripe_subscription_id, null: false, index: { unique: true }
      t.string :stripe_checkout_session_id, index: { unique: true }
      t.timestamp :expired_at, null: false

      t.timestamps
    end
  end
end
