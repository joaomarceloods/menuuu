class Menu::BuildDefault < ApplicationService
  def call(menu_params)
    Menu.new(menu_params.merge(name: I18n.t('menu.default.name'))).tap do |menu|
      menu.menu_sections.build(menu:).tap do |menu_section|
        menu_section.menu_items.build([
          { menu_section: },
          { menu_section: },
          { menu_section: },
        ])
      end
    end
  end
end
