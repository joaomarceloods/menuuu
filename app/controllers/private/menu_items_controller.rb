class Private::MenuItemsController < Private::ApplicationController
  before_action :set_menu_item, only: %i[ update destroy ]

  def create
    menu_item = MenuItem.build(menu_item_params)
    menu_item.save! if Can.create_menu_item!(menu_item.menu)
    redirect_to private_menu_path(menu_item.menu.id)
  end

  def update
    # TODO: handle error
    @menu_item.update!(menu_item_params)

    if @menu_item.saved_change_to_position? || @menu_item.saved_change_to_menu_section_id?
      redirect_to private_menu_path(@menu_item.menu_section.menu_id)
    else
      head :no_content
    end
  end

  def destroy
    @menu_item.destroy!
    redirect_to private_menu_path(@menu_item.menu_section.menu_id)
  end

  private
    def set_menu_item
      @menu_item = Current.user.menu_items.find(params[:id])
    end

    def menu_item_params
      params.require(:menu_item).permit(:name, :price, :position, :menu_section_id)
    end
end
