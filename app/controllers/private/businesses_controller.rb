class Private::BusinessesController < Private::ApplicationController
  def new
    @business = Business.new
  end

  def create
    @business = Current.user.build_business(business_params)

    if @business.save
      redirect_to [:private, :menus]
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
