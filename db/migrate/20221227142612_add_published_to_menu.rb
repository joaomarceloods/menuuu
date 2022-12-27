class AddPublishedToMenu < ActiveRecord::Migration[7.0]
  def change
    add_column :menus, :published, :boolean, null: false, default: false
  end
end
