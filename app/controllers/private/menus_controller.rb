class Private::MenusController < Private::ApplicationController
  before_action :set_menu, only: %i[ show edit update destroy ]

  def index
    @menus = Current.user.business.menus.order(:created_at)
  end

  def show
  end

  def new
    @menu = Menu.new
  end

  def edit
  end

  def create
    menu = Menu::BuildDefault.call(business: Current.user.business)
    menu.save! if Can.create_menu!(menu.business)
    redirect_to [:private, menu]
  end

  def update
    @menu.update(menu_params)

    respond_to do |format|
      if @menu.saved_change_to_name?
        # To keep focus on the name input, send an empty response
        format.turbo_stream
      end

      format.html { redirect_to private_menu_path(@menu) }
    end
  end

  def destroy
    @menu.destroy
    redirect_to [:private, :menus], notice: t('.success', name: @menu.name)
  end

  private
    def set_menu
      @menu = Current.user.menus.find(params[:id])
    end

    def menu_params
      params.require(:menu).permit(:name, :published)
    end
end
