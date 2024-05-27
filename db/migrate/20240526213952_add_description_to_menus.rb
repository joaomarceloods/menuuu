class AddDescriptionToMenus < ActiveRecord::Migration[7.1]
  def change
    add_column :menus, :description, :string
  end
end
