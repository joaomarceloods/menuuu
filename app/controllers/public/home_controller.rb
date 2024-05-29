class Public::HomeController < Public::ApplicationController
  before_action :redirect_to_locale
  around_action :switch_param_locale

  def index
    @menu = Menu.find_by!(demo: true, locale: I18n.locale)
    fresh_when @menu
    expires_in 24.hours, public: true
  end

  private

  def redirect_to_locale
    redirect_to "/#{I18n.locale}" unless params[:locale].present? || I18n.locale == I18n.default_locale
  end

  def switch_param_locale(&action)
    logger.debug "* params[:locale]: #{params[:locale]}"
    logger.debug "* Locale set to '#{params[:locale]}'"
    I18n.with_locale(params[:locale], &action)
  end
end
