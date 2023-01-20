class Public::BusinessesController < Public::ApplicationController
  def show
    @business = Business.find(params[:id])
    @menus = @business.menus.where(published: true)
    redirect_to_first_menu_if_only_one(@menus)
  end

  private

  def redirect_to_first_menu_if_only_one(menus)
    if @menus.one? && previous_path != public_menu_path(@menus.first)
      redirect_to public_menu_path(@menus.first)
    end
  end

  def previous_path
    request.referrer && URI.parse(request.referrer).path
  end
end
