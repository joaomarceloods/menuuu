class Private::MenuItemsController < Private::ApplicationController
  before_action :set_menu_item, only: %i[ update destroy ]

  # POST /menu_items
  def create
    # TODO: handle error
    @menu_item = MenuItem.create!(menu_item_params)
    redirect_to private_menu_path(@menu_item.menu_section.menu_id)
  end

  # PATCH/PUT /menu_items/1
  def update
    # TODO: handle error
    @menu_item.update!(menu_item_params)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to private_menu_path(@menu_item.menu_section.menu_id) }
    end
  end

  # DELETE /menu_items/1
  def destroy
    # TODO: handle error
    @menu_item.destroy!
    redirect_to private_menu_path(@menu_item.menu_section.menu_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = Current.user.menu_items.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def menu_item_params
      params.require(:menu_item).permit(:name, :price, :position, :menu_section_id)
    end
end
