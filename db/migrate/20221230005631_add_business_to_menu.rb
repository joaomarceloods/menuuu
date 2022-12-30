class AddBusinessToMenu < ActiveRecord::Migration[7.0]
  def change
    add_reference :menus, :business, null: false, foreign_key: true
  end
end
