class RenameExampleMenu < ActiveRecord::Migration[7.1]
  def change
    menu = Menu.find_by(demo: true, locale: :en)
    menu&.update!(name: "The Menu")
    menu&.business&.update!(name: "All Menus")
  end
end
