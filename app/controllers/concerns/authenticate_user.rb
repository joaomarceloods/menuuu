module AuthenticateUser
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
  end

  def authenticate
    # The MenuItem model needs Current.user to be set.
    # Controllers also call Current.user for consistency, instead of #current_user.
    Current.user = authenticate_user!
  end
end
