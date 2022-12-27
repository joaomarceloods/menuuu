class Public::MenusController < Public::ApplicationController
  def show
    @menu = Menu.where(published: true).find(params[:id])
  end
end
