class AddLocaleToMenus < ActiveRecord::Migration[7.1]
  def change
    add_column :menus, :locale, :string
  end
end
