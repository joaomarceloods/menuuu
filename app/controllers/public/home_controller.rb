class Public::HomeController < Public::ApplicationController
  def index
    @menu = Menu.find_by!(demo: true)
    fresh_when last_modified: @menu.updated_at, etag: @menu, public: true
    expires_in 24.hours, public: true
  end
end
