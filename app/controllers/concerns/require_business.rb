module RequireBusiness
  extend ActiveSupport::Concern

  included do
    before_action :require_business
  end

  def require_business
    if !user_has_business? && !is_new_business_page?
      redirect_to [:new, :private, :business]
    end
  end

  def user_has_business?
    Current.user.business.present?
  end

  def is_new_business_page?
    controller_path == "private/businesses" && action_name.in?(%w[ new create ])
  end
end