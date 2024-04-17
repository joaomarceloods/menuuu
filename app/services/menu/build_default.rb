class Menu::BuildDefault < ApplicationService
  def call(menu_params)
    Menu.new(menu_params.merge(name: "New Menu (rename)")).tap do |menu|
      menu.menu_sections.build(menu:, name: "This is a section").tap do |menu_section|
        menu_section.menu_items.build([
          { menu_section:, name: "Rename this item" },
          { menu_section:, name: "Rename the section" },
          { menu_section:, name: "Rename the menu at the top" },
        ])
      end

      menu.menu_sections.build(menu:, name: "Another section").tap do |menu_section|
        menu_section.menu_items.build([
          { menu_section:, name: "Drag items & sections around" },
          { menu_section:, name: "You can delete sections" },
          { menu_section:, name: "Set price on the right", price: 9.90 },
        ])
      end
    end
  end
end
