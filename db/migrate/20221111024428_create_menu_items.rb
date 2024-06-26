class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.references :menu_section, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.decimal :price, precision: 8, scale: 2
      t.integer :position, null: false

      t.timestamps
    end
  end
end
