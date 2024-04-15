class Menu::BuildDefault < ApplicationService
  def call(menu_params)
    Menu.new(menu_params.merge(name: "My Menu")).tap do |menu|
      menu.menu_sections.build(menu:, name: "Tips Section").tap do |menu_section|
        menu_section.menu_items.build([
          { menu_section:, name: "Rename this item" },
          { menu_section:, name: "Change price --->", price: 10 },
          { menu_section:, name: "Change the section title" },
          { menu_section:, name: "Rename the menu" },
          { menu_section:, name: "Drag items & sections around" },
        ])
      end
    end
  end
end
