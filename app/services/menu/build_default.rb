class Menu::BuildDefault < ApplicationService
  def call(menu_params)
    Menu.new(menu_params.merge(name: "New Menu (rename)")).tap do |menu|
      menu.menu_sections.build(menu:, name: "This is a section").tap do |menu_section|
        menu_section.menu_items.build([
          { menu_section:, name: "Rename this item" },
          { menu_section:, name: "Set item's price →", price: 10 },
          { menu_section:, name: "Change the section title" },
          { menu_section:, name: "Rename the menu" },
          { menu_section:, name: "Drag items & sections around" },
        ])
      end
    end
  end
end
