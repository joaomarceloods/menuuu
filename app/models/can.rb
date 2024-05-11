class Can
  def self.create_menu?(menu)
    limit = menu.business.subscribed? ? 10 : 1
    menu.business.menus.count < limit
  end

  def self.create_menu_section?(menu_section)
    limit = menu_section.business.subscribed? ? 1000 : 10
    menu_section.menu.menu_sections.count < limit
  end

  def self.create_menu_item?(menu_item)
    limit = menu_item.business.subscribed? ? 1000 : 10
    menu_item.menu.menu_items.count < limit
  end
end
