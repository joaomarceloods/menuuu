class Private::StripePortalSessionsController < Private::ApplicationController
  def show
    checkout_session_id = Current.user.business.subscription.stripe_checkout_session_id
    checkout_session = Stripe::Checkout::Session.retrieve(checkout_session_id)

    portal_session = Stripe::BillingPortal::Session.create({
      customer: checkout_session.customer,
      return_url: request.referrer || private_menus_url
    })

    redirect_to portal_session.url, allow_other_host: true
  end
end
