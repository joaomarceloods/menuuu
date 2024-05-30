class Private::StripeCheckoutSessionsController < Private::ApplicationController
  def show
    prices = Stripe::Price.list(
      lookup_keys: [params[:lookup_key]],
      expand: ['data.product']
    )

    session = Stripe::Checkout::Session.create({
      mode: 'subscription',
      line_items: [{
        quantity: 1,
        price: prices.data[0].id
      }],
      client_reference_id: Current.user.business.id,
      customer_email: Current.user.email,
      success_url: private_stripe_checkout_success_url(redirect_to: request.referrer),
      cancel_url: private_stripe_checkout_cancel_url(redirect_to: request.referrer),
    })

    redirect_to session.url, status: 303, allow_other_host: true
  end
end
