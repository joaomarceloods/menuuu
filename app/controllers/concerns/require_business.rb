module RequireBusiness
  extend ActiveSupport::Concern

  included do
    before_action do
      if !user_has_business? && !is_new_business_page?
        redirect_to [:new, :private, :business]
      end
    end
  end

  def user_has_business?
    current_user.business.present?
  end

  def is_new_business_page?
    controller_path == "private/businesses" && action_name.in?(%w[ new create ])
  end
end
