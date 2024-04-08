class BusinessServices::CreateBusinessWithMenu < ApplicationService

  MENU_ITEMS_EATS = [
    { name: "Cheese Burger", price: "15" },
    { name: "French Fries", price: "10" },
  ]

  MENU_ITEMS_DRINKS = [
    { name: "Soda", price: "5" },
  ]

  def initialize(business_params)
    @business_params = business_params
  end

  def call
    ActiveRecord::Base.transaction do
      business = Business.create!(@business_params)
      menu = business.menus.create!(name: "Menu")

      menu.menu_sections.create!(name: "Eats").tap do |menu_section|
        menu_section.menu_items.create!(MENU_ITEMS_EATS)
      end

      menu.menu_sections.create!(name: "Drinks").tap do |menu_section|
        menu_section.menu_items.create!(MENU_ITEMS_DRINKS)
      end

      [business, menu]
    end
  end
end
