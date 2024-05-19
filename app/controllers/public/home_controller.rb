class Public::HomeController < Public::ApplicationController
  def index
    @menu = Business.first.menus.first
    fresh_when last_modified: @menu.updated_at, etag: @menu, public: true
    expires_in 24.hours, public: true
  end
end
