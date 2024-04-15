class Business::BuildDefault < ApplicationService
  def call(business_params)
    Business.new(business_params).tap do |business|
      business.menus << Menu::BuildDefault.call(business: business)
    end
  end
end
