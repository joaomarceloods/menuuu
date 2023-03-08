class Private::MenuSectionsController < Private::ApplicationController
  before_action :set_menu_section, only: %i[ update destroy ]

  # POST /menu_sections
  def create
    @menu_section = MenuSection.create!(menu_section_params)

    respond_to do |format|
      format.html { redirect_to private_menu_path(@menu_section.menu_id) }
    end
  end

  # PATCH/PUT /menu_sections/1
  def update
    @menu_section.update(menu_section_params)

    respond_to do |format|
      format.turbo_stream
      format.json { head :ok }
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  # DELETE /menu_sections/1
  def destroy
    @menu_section.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back(fallback_location: root_path) }
    end
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
