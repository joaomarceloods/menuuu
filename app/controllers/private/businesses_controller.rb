class Private::BusinessesController < Private::ApplicationController
  def new
    @business = Business.new
  end

  def create
    @business, menu = create_business_and_default_menu

    if menu.present?
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

  def create_business_and_default_menu
    ActiveRecord::Base.transaction do
      business = Current.user.create_business!(business_params)
      menu = business.menus.create!(name: "#{business.name} Menu")
      menu.menu_items.create!([
        { name: "Cheese Burger", price: "15" },
        { name: "French Fries", price: "10" },
        { name: "Soda", price: "5" },
      ])
      [business, menu]
    end
  end
end
