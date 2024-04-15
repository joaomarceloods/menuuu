class Business::CreateWithMenu < ApplicationService
  def call(business_params)
    business = Business.new(business_params)

    ActiveRecord::Base.transaction do
      business.save!
      business.menus.create!(name: "My First Menu").tap do |menu|
        menu.menu_sections.create!(name: "Some Tips For You (edit me)").tap do |menu_section|
          menu_section.menu_items.create!([
            { name: "Rename this item" },
            { name: "Change price --->", price: 10 },
            { name: "Rename the menu" },
            { name: "Rename the section above" },
            { name: "Drag items & sections around" },
          ])
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.debug e
    end

    return business
  end
end
