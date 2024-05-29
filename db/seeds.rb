# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.find_by(email: Rails.application.credentials.dig(:admin, :email)) ||
        User.create!(
          email: Rails.application.credentials.dig(:admin, :email),
          password: Rails.application.credentials.dig(:admin, :password),
        )

business = Business.find_or_create_by!(user:, name: "The Menuuu")

Subscription.find_or_create_by!(business:, stripe_subscription_id: "sub_demo", expired_at: "3000-01-01")

# Create a demo menu in English
ActiveRecord::Base.transaction do
  break if Menu.exists?(demo: true, locale: :en)

  menu = Menu.create!(business:, name: "The Menuuu", published: true, demo: true, locale: :en)

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

# Create a demo menu in Spanish
ActiveRecord::Base.transaction do
  break if Menu.exists?(demo: true, locale: :es)

  menu = Menu.create!(business:, name: "El Menú", published: true, demo: true, locale: :es)

  MenuSection.create!(menu:, name: "Aperitivos") do |menu_section|
    MenuItem.create!(menu_section:, name: "Pepinillos Fritos", price: 5.99)
    MenuItem.create!(menu_section:, name: "Palitos de Mozzarella", price: 6.99)
    MenuItem.create!(menu_section:, name: "Aros de Cebolla", price: 4.99)
  end

  MenuSection.create!(menu:, name: "Platos Principales").tap do |menu_section|
    MenuItem.create!(menu_section:, name: "Costillas", price: 15.99)
    MenuItem.create!(menu_section:, name: "Pollo", price: 12.99)
    MenuItem.create!(menu_section:, name: "Cerdo Desmenuzado", price: 13.99)
    MenuItem.create!(menu_section:, name: "Brisket", price: 14.99)
    MenuItem.create!(menu_section:, name: "Salchicha", price: 11.99)
  end

  MenuSection.create!(menu:, name: "Acompañamientos").tap do |menu_section|
    MenuItem.create!(menu_section:, name: "Papas Fritas", price: 2.99)
    MenuItem.create!(menu_section:, name: "Macarrones con Queso", price: 3.99)
    MenuItem.create!(menu_section:, name: "Ensalada de Col", price: 1.99)
  end

  MenuSection.create!(menu:, name: "Bebidas").tap do |menu_section|
    MenuItem.create!(menu_section:, name: "Soda", price: 1.99)
    MenuItem.create!(menu_section:, name: "Cerveza", price: 3.99)
    MenuItem.create!(menu_section:, name: "Vino", price: 5.99)
    MenuItem.create!(menu_section:, name: "Cóctel", price: 7.99)
    MenuItem.create!(menu_section:, name: "Agua", price: 0.99)
  end

  MenuSection.create!(menu:, name: "Postre").tap do |menu_section|
    MenuItem.create!(menu_section:, name: "Cheesecake", price: 4.99)
    MenuItem.create!(menu_section:, name: "Helado", price: 3.99)
    MenuItem.create!(menu_section:, name: "Pastel", price: 4.99)
  end
end

# Create a demo menu in Portuguese
ActiveRecord::Base.transaction do
  break if Menu.exists?(demo: true, locale: :pt)

  menu = Menu.create!(business:, name: "O Cardápio", published: true, demo: true, locale: :pt)

  MenuSection.create!(menu:, name: "Aperitivos") do |menu_section|
    MenuItem.create!(menu_section:, name: "Picles Fritos", price: 5.99)
    MenuItem.create!(menu_section:, name: "Palitos de Mussarela", price: 6.99)
    MenuItem.create!(menu_section:, name: "Anéis de Cebola", price: 4.99)
  end

  MenuSection.create!(menu:, name: "Pratos Principais").tap do |menu_section|
    MenuItem.create!(menu_section:, name: "Costelas", price: 15.99)
    MenuItem.create!(menu_section:, name: "Frango", price: 12.99)
    MenuItem.create!(menu_section:, name: "Carne de Porco Desfiada", price: 13.99)
    MenuItem.create!(menu_section:, name: "Brisket", price: 14.99)
    MenuItem.create!(menu_section:, name: "Linguiça", price: 11.99)
  end

  MenuSection.create!(menu:, name: "Acompanhamentos").tap do |menu_section|
    MenuItem.create!(menu_section:, name: "Batatas Fritas", price: 2.99)
    MenuItem.create!(menu_section:, name: "Macarrão com Queijo", price: 3.99)
    MenuItem.create!(menu_section:, name: "Salada de Repolho", price: 1.99)
  end

  MenuSection.create!(menu:, name: "Bebidas").tap do |menu_section|
    MenuItem.create!(menu_section:, name: "Refrigerante", price: 1.99)
    MenuItem.create!(menu_section:, name: "Cerveja", price: 3.99)
    MenuItem.create!(menu_section:, name: "Vinho", price: 5.99)
    MenuItem.create!(menu_section:, name: "Coquetel", price: 7.99)
    MenuItem.create!(menu_section:, name: "Água", price: 0.99)
  end

  MenuSection.create!(menu:, name: "Sobremesa").tap do |menu_section|
    MenuItem.create!(menu_section:, name: "Cheesecake", price: 4.99)
    MenuItem.create!(menu_section:, name: "Sorvete", price: 3.99)
    MenuItem.create!(menu_section:, name: "Torta", price: 4.99)
  end
end
