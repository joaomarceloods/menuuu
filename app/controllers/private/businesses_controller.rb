class Private::BusinessesController < Private::ApplicationController
  def new
    @business = Business.new
  end

  def create
    @business, menu = CreateBusinessWithMenu.call(business_params.merge(user: Current.user))

    if @business.present? && menu.present?
      redirect_to [:private, menu]
    else
      render :new
    end
  end

  def update
    # The RequireBusiness concern ensures the business exists.
    @business = Current.user.business

    if @business.update(business_params)
      head :ok
    else
      redirect_to [:private, :menus]
    end
  end

  private

  def business_params
    params.require(:business).permit(:name)
  end
end
