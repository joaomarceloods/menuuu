class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.references :business, null: false, foreign_key: true
      t.string :name, null: false
      t.boolean :published, null: false, default: false
      t.boolean :demo, null: false, default: false

      t.timestamps
    end
  end
end
