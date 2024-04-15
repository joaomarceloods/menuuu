# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  return if User.any?

  ActiveRecord::Base.transaction do
    user = User.create!(email: "user@example.com", password: "password")

    Business::BuildDefault.call(user: user, name: "My Restaurant")
  end
end
