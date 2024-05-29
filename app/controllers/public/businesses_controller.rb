class Public::BusinessesController < Public::ApplicationController
  def show
    @business = Business.find(params[:id])
    @menus = @business.menus.where(published: true)
    fresh_when @menus
    expires_in 24.hours, public: true
    redirect_to public_menu_path(@menus.first) if @menus.one? && !coming_from_menu?
  end

  private

  def coming_from_menu?
    previous_path&.starts_with?('/menu/')
  end

  def previous_path
    request.referrer && URI.parse(request.referrer).path
  end
end
