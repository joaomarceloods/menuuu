class Private::StripeCheckoutSuccessesController < ApplicationController
  def show
    redirect_to params.fetch(:redirect_to) { private_menus_path }, notice: t('.notice')
  end
end
