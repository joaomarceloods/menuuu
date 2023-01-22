class Private::MenusController < Private::ApplicationController
  before_action :set_menu, only: %i[ show edit update destroy ]

  # GET /menus
  def index
    @menus = Current.user.menus.order(:created_at)
  end

  # GET /menus/1
  def show
    @menu_items = @menu.menu_items.order(:created_at)
    @menu_item = @menu.menu_items.build
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
    @menu = Current.user.menus.build(menu_params)

    if @menu.save
      redirect_to [:private, @menu], notice: "Menu was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /menus/1
  def update
    # TODO: handle error
    @menu.update(menu_params)

    respond_to do |format|
      format.turbo_stream do
        redirect_to [:private, @menu], notice: "Menu was successfully updated."
      end
      format.html do
        render :edit, status: :unprocessable_entity
      end
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