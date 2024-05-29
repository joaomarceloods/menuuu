class Public::MenusController < Public::ApplicationController
  def show
    @menu = Menu.where(published: true).find(params[:id])
    fresh_when @menu
    expires_in 24.hours
  end
end
