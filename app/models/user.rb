class User < ApplicationRecord
  has_one :business
  has_many :menus, through: :business
  has_many :menu_sections, through: :menus
  has_many :menu_items, through: :menu_sections

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable
end
