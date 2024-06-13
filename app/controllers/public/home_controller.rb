class Public::HomeController < Public::ApplicationController
  def index
    @menu = Menu.find_by!(demo: true, locale: I18n.locale)
    fresh_when @menu
    expires_in 24.hours, public: true
  end
end
