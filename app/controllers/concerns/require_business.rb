module RequireBusiness
  extend ActiveSupport::Concern

  included do
    before_action :require_business
  end

  def require_business
    @business = Current.user.business
    if @business.present? && creating_business?
      redirect_to [:private, :menus]
    elsif @business.blank? && !creating_business?
      redirect_to [:new, :private, :business]
    end
  end

  def creating_business?
    controller_path == "private/businesses" && action_name.in?(%w[ new create ])
  end
end
