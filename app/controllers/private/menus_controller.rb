class Private::MenusController < Private::ApplicationController
  before_action :set_menu, only: %i[ show edit update destroy ]

  def index
    @business = current_user.business
    @menus = @business.menus.order(:created_at)
  end

  def show
  end

  def new
    @menu = Menu.new
  end

  def edit
  end

  def create
    @menu = Menu::BuildDefault.call(business: Current.user.business)

    if @menu.save
      redirect_to [:private, @menu]
    else
      redirect_to [:private, :menus], notice: "Failed to create a new menu. Try again later."
    end
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
    redirect_to [:private, :menus], notice: "Menu was successfully destroyed."
  end

  private
    def set_menu
      @menu = Current.user.menus.find(params[:id])
    end

    def menu_params
      params.require(:menu).permit(:name, :published)
    end
end
