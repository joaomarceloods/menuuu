class Stripe::WebhooksController < ApplicationController
  skip_forgery_protection

  def create
    payload = request.body.read
    signature = request.env['HTTP_STRIPE_SIGNATURE'];
    webhook_secret = Rails.application.credentials.stripe.webhook_secret
    event = Stripe::Webhook.construct_event(payload, signature, webhook_secret)

    # Stripe triggers `customer.subscription.created` before `checkout.session.completed`.
    # But only `checkout.session.completed` includes the `client_reference_id` (`business_id`).
    # So for `customer.subscription.created` we create the subscription without `business_id`.
    # Then for `checkout.session.completed` we set the subscription's `business_id`.
    case event.type
    when 'customer.subscription.created'
      handle_subscription_created(event)
    when 'customer.subscription.updated'
      handle_subscription_updated(event)
    when 'customer.subscription.deleted'
      handle_subscription_deleted(event)
    when 'checkout.session.completed'
      handle_session_completed(event)
    end

    head :ok
  end

  private

  def handle_subscription_created(event)
    subscription = event.data.object
    Subscription.create!(
      stripe_subscription_id: subscription.id,
      expired_at: Time.zone.at(subscription.current_period_end)
    )
  end

  def handle_subscription_updated(event)
    subscription = event.data.object
    Subscription
      .find_by!(stripe_subscription_id: subscription.id)
      .update!(expired_at: Time.zone.at(subscription.current_period_end))
  end

  def handle_subscription_deleted(event)
    subscription = event.data.object
    Subscription.where(stripe_subscription_id: subscription.id).destroy_all
  end

  def handle_session_completed(event)
    session = event.data.object
    Subscription
      .find_by!(stripe_subscription_id: session.subscription)
      .update!(
        stripe_checkout_session_id: session.id,
        business_id: session.client_reference_id,
      )
  end
end
