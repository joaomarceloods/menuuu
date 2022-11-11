class CreateMenuSections < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_sections do |t|
      t.references :menu, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
