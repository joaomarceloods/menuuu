class ApplicationController < ActionController::Base
  around_action :switch_locale

  def after_sign_in_path_for(resource)
    private_menus_path
  end

  private

  def switch_locale(&action)
    locale = params[:locale] || headers_locale
    logger.debug "* Locale set to '#{locale}'"
    I18n.with_locale(locale, &action)
  end

  def headers_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    available_locales = I18n.available_locales.map(&:to_s)
    client_locales = request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/[a-z]{2}\-[A-Z]{2}|[a-z]{2}/)
    client_locales&.find { |l| l.in?(available_locales) } || I18n.default_locale
  end
end
