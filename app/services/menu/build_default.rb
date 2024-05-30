class Menu::BuildDefault < ApplicationService
  def call(menu_params)
    Menu.new(menu_params.merge(name: I18n.t('menu.default.name'))).tap do |menu|
      menu.menu_sections.build(menu:, name: I18n.t('menu.default.section_1')).tap do |menu_section|
        menu_section.menu_items.build([
          { menu_section:, name: I18n.t('menu.default.item_1_1'), description: I18n.t('menu.default.description_1_1') },
          { menu_section:, name: I18n.t('menu.default.item_1_2'), description: I18n.t('menu.default.description_1_2') },
          { menu_section:, name: I18n.t('menu.default.item_1_3'), description: I18n.t('menu.default.description_1_3') },
        ])
      end

      menu.menu_sections.build(menu:, name: I18n.t('menu.default.section_2')).tap do |menu_section|
        menu_section.menu_items.build([
          { menu_section:, name: I18n.t('menu.default.item_2_1'), description: I18n.t('menu.default.description_2_1') },
          { menu_section:, name: I18n.t('menu.default.item_2_2') },
          { menu_section:, name: I18n.t('menu.default.item_2_3'), price: 9.90 },
        ])
      end
    end
  end
end
