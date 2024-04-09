class Private::BusinessesController < Private::ApplicationController
  def new
    @business = Business.new
  end

  def create
    @business = BusinessServices::CreateBusinessWithMenu.call(business_params.merge(user_id: Current.user.id))

    if @business.persisted?
      redirect_to [:private, @business.menus.first]
    else
      render :new
    end
  end

  def update
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
