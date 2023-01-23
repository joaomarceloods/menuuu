module Private::CreateDemonstrativeMenu
  extend ActiveSupport::Concern

  DEMONSTRATIVE_MENU_ITEMS = [
    { name: "Cheese Burger", price: "15" },
    { name: "French Fries", price: "10" },
    { name: "Soda", price: "5" },
  ]

  included do
    def create_demonstrative_menu(business)
      ActiveRecord::Base.transaction do
        business.menus.create!(name: "#{business.name} Menu").tap do |menu|
          menu.menu_items.create!(DEMONSTRATIVE_MENU_ITEMS)
        end
      end
    end
  end
end
