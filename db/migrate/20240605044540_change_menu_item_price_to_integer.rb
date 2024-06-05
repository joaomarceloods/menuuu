class ChangeMenuItemPriceToInteger < ActiveRecord::Migration[7.1]
  def up
    MenuItem.update_all("price = price * 100")
    change_column :menu_items, :price, :integer
  end

  def down
    change_column :menu_items, :price, :decimal, precision: 8, scale: 2
    MenuItem.update_all("price = price / 100")
  end
end
