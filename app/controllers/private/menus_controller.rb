class Private::MenusController < Private::ApplicationController
  before_action :set_menu, only: %i[ show edit update destroy ]

  # GET /menus
  def index
    @business = current_user.business
    @menus = @business.menus.order(:created_at)
  end

  # GET /menus/1
  def show
  end

  # GET /menus/new
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  def create
    @menu = Current.user.menus.build(name: "Menu")

    if @menu.save
      redirect_to [:private, @menu], notice: "Menu was successfully created."
    else
      redirect_to [:private, :menus], notice: "Failed to create a new menu. Try again later."
    end
  end

  # PATCH/PUT /menus/1
  def update
    # TODO: handle error
    @menu.update(menu_params)

    respond_to do |format|
      if @menu.saved_change_to_name?
        # To keep focus on the name input, send an empty response
        format.turbo_stream
      end

      if @menu.saved_change_to_published?
        if @menu.published?
          flash[:notice] = "Menu was published - #{helpers.link_to('View as customer', public_menu_path(@menu), target: :_blank).html_safe}"
        else
          flash[:notice] = "Menu was unpublished"
        end
      end

      format.html { redirect_to private_menu_path(@menu) }
    end
  end

  # DELETE /menus/1
  def destroy
    @menu.destroy
    redirect_to [:private, :menus], notice: "Menu was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Current.user.menus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def menu_params
      params.require(:menu).permit(:name, :published)
    end
end
