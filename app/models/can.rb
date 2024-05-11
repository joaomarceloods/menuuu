class Can
  class AuthorizationError < StandardError
  end

  def self.create_menu?(business)
    limit = business.subscribed? ? 10 : 1
    business.menus.count < limit
  end

  def self.create_menu!(business)
    create_menu?(business) or raise AuthorizationError
  end

  def self.create_menu_section?(menu)
    limit = menu.business.subscribed? ? 1000 : 10
    menu.menu_sections.count < limit
  end

  def self.create_menu_section!(menu)
    create_menu_section?(menu) or raise AuthorizationError
  end

  def self.create_menu_item?(menu)
    limit = menu.business.subscribed? ? 1000 : 10
    menu.menu_items.count < limit
  end

  def self.create_menu_item!(menu)
    create_menu_item?(menu) or raise AuthorizationError
  end
end
