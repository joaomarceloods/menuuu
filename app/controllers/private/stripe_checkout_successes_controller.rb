class Private::StripeCheckoutSuccessesController < ApplicationController
  def show
    flash[:notice] = 'Subscribed! Add up to 10 menus and 1,000 items per menu.'
    redirect_to params.fetch(:redirect_to) { private_menus_path }
  end
end
