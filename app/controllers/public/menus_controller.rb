class Public::MenusController < Public::ApplicationController
  def show
    @menu = Menu.where(published: true).find(params[:id])
    fresh_when last_modified: @menu.updated_at, etag: @menu, public: true
    expires_in 24.hours, public: true
  end
end
