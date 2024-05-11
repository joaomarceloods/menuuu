class Private::MenuSectionsController < Private::ApplicationController
  before_action :set_menu_section, only: %i[ update destroy ]

  def create
    menu_section = MenuSection.new(menu_section_params)
    menu_section.save! if Can.create_menu_section?(menu_section)
    redirect_to private_menu_path(menu_section.menu_id)
  end

  def update
    @menu_section.update!(menu_section_params)

    if @menu_section.saved_change_to_position?
      redirect_to private_menu_path(@menu_section.menu_id)
    else
      head :no_content
    end
  end

  def destroy
    @menu_section.destroy!
    redirect_to private_menu_path(@menu_section.menu_id)
  end

  private
    def set_menu_section
      @menu_section = Current.user.menu_sections.find(params[:id])
    end

    def menu_section_params
      params.require(:menu_section).permit(:name, :position, :menu_id)
    end
end
