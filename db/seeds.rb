# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  ActiveRecord::Base.transaction do
    user = User.create!(email: "jon@doe", password: "123123")

    business = Business.create!(user: user, name: "Doe's")

    menu = Menu.create!(business: business, name: "Menu")

    menu.menu_items.create!(Private::CreateDemonstrativeMenu::DEMONSTRATIVE_MENU_ITEMS)
  end
end
