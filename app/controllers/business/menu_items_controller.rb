class Business::MenuItemsController < ApplicationController
  before_action :set_menu_item, only: %i[ edit update destroy ]

  # POST /menu_items
  def create
    @menu_item = MenuItem.create(menu_item_params)

    respond_to do |format|
      format.turbo_stream
      format.html do
        redirect_to [:business, @menu_item.menu]
      end
    end
  end

  # PATCH/PUT /menu_items/1
  def update
    @menu_item.update(menu_item_params)

    respond_to do |format|
      format.turbo_stream
      format.html do
        redirect_to [:business, @menu_item.menu]
      end
    end
  end

  # DELETE /menu_items/1
  def destroy
    @menu_item.destroy

    respond_to do |format|
      format.turbo_stream
      format.html do
        redirect_to [:business, @menu_item.menu]
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
