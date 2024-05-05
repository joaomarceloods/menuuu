class Private::StripeCheckoutCancelsController < ApplicationController
  def show
    flash[:notice] = "Payment cancelled. You're still on the free plan."
    redirect_to params.fetch(:redirect_to) { private_menus_path }
  end
end
