# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

return if User.any?

ActiveRecord::Base.transaction do
  user = User.create!(
    email: Rails.application.credentials.dig(:admin, :email),
    password: Rails.application.credentials.dig(:admin, :password),
  )

  business = Business.create!(user:, name: "Riccky's Ribs")
  Subscription.create!(business:, stripe_subscription_id: "sub_123456", expired_at: 100.years.from_now)
  menu = Menu.create!(business:, name: "Riccky's Ribs", published: true)

  MenuSection.create!(menu:, name: "Appetizers") do |menu_section|
    MenuItem.create!(menu_section:, name: "Fried Pickles", price: 5.99)
    MenuItem.create!(menu_section:, name: "Mozzarella Sticks", price: 6.99)
    MenuItem.create!(menu_section:, name: "Onion Rings", price: 4.99)
  end

  MenuSection.create!(menu:, name: "Entrees").tap do |menu_section|
    MenuItem.create!(menu_section:, name: "Ribs", price: 15.99)
    MenuItem.create!(menu_section:, name: "Chicken", price: 12.99)
    MenuItem.create!(menu_section:, name: "Pulled Pork", price: 13.99)
    MenuItem.create!(menu_section:, name: "Brisket", price: 14.99)
    MenuItem.create!(menu_section:, name: "Sausage", price: 11.99)
  end

  MenuSection.create!(menu:, name: "Sides").tap do |menu_section|
    MenuItem.create!(menu_section:, name: "Fries", price: 2.99)
    MenuItem.create!(menu_section:, name: "Mac & Cheese", price: 3.99)
    MenuItem.create!(menu_section:, name: "Cole Slaw", price: 1.99)
  end

  MenuSection.create!(menu:, name: "Drinks").tap do |menu_section|
    MenuItem.create!(menu_section:, name: "Soda", price: 1.99)
    MenuItem.create!(menu_section:, name: "Beer", price: 3.99)
    MenuItem.create!(menu_section:, name: "Wine", price: 5.99)
    MenuItem.create!(menu_section:, name: "Cocktail", price: 7.99)
    MenuItem.create!(menu_section:, name: "Water", price: 0.99)
  end

  MenuSection.create!(menu:, name: "Desert").tap do |menu_section|
    MenuItem.create!(menu_section:, name: "Cheesecake", price: 4.99)
    MenuItem.create!(menu_section:, name: "Ice Cream", price: 3.99)
    MenuItem.create!(menu_section:, name: "Pie", price: 4.99)
  end
end
