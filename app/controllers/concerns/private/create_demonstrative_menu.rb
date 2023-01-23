module Private::CreateDemonstrativeMenu
  extend ActiveSupport::Concern

  DEMONSTRATIVE_MENU_ITEMS = [
    { name: "Cheese Burger", price: "15" },
    { name: "French Fries", price: "10" },
    { name: "Soda", price: "5" },
  ]

  included do
    def create_business_and_demonstrative_menu(business_params)
      ActiveRecord::Base.transaction do
        business = Current.user.create_business!(business_params)
        menu = business.menus.create!(name: "Menu")
        menu.menu_items.create!(DEMONSTRATIVE_MENU_ITEMS)
        [business, menu]
      end
    end
  end
end
