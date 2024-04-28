class Public::MenusController < Public::ApplicationController
  def show
    @menu = Menu.where(published: true).find(params[:id])
    @menu_sections = @menu.publicly_visible_menu_sections.order(:position)
    fresh_when last_modified: @menu.updated_at, etag: @menu
  end
end
