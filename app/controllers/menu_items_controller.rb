class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: %i[ edit update destroy ]

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new(menu_item_params)
  end

  # GET /menu_items/1/edit
  def edit
  end

  # POST /menu_items
  def create
    @menu_item = MenuItem.new(menu_item_params)

    if @menu_item.save
      respond_to do |format|
        format.turbo_stream do
          @new_menu_item = MenuItem.new(menu: @menu_item.menu)
        end
        format.html do
          redirect_to @menu_item.menu
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /menu_items/1
  def update
    if @menu_item.update(menu_item_params)
      respond_to do |format|
        format.turbo_stream
        format.html do
          redirect_to @menu_item.menu
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /menu_items/1
  def destroy
    @menu_item.destroy

    respond_to do |format|
      format.turbo_stream
      format.html do
        redirect_to @menu_item.menu, notice: "Menu item was successfully destroyed."
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def menu_item_params
      params.require(:menu_item).permit(:name, :price, :menu_id)
    end
end
