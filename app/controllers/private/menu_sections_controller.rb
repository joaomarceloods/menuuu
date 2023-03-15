class Private::MenuSectionsController < Private::ApplicationController
  before_action :set_menu_section, only: %i[ update destroy ]

  # POST /menu_sections
  def create
    # TODO: handle error
    @menu_section = MenuSection.create!(menu_section_params)
    redirect_to private_menu_path(@menu_section.menu_id)
  end

  # PATCH/PUT /menu_sections/1
  def update
    # TODO: handle error
    @menu_section.update!(menu_section_params)

    if @menu_section.saved_change_to_position?
      redirect_to private_menu_path(@menu_section.menu_id)
    else
      head :no_content
    end
  end

  # DELETE /menu_sections/1
  def destroy
    # TODO: handle error
    @menu_section.destroy!
    redirect_to private_menu_path(@menu_section.menu_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_section
      @menu_section = Current.user.menu_sections.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def menu_section_params
      params.require(:menu_section).permit(:name, :position, :menu_id)
    end
end
