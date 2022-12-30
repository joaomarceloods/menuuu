class Private::BusinessesController < Private::ApplicationController
  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)

    if @business.save
      redirect_to [:private, :menus]
    else
      render :new
    end
  end

  def update
    @business = Business.find(params[:id])

    if @business.update(business_params)
      head :ok
    else
      redirect_to [:private, :menus]
    end
  end

  private

  def business_params
    params.require(:business).permit(:name).merge(user: current_user)
  end
end
