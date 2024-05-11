class Can
  class AuthorizationError < StandardError
  end

  def self.create_menu?(business)
    limit = business.subscribed? ? 10 : 1
    business.menus.count < limit
  end

  def self.create_menu!(business)
    raise AuthorizationError unless create_menu?(business)
  end

  def self.create_menu_section?(menu)
    limit = menu.business.subscribed? ? 1000 : 10
    menu.menu.menu_sections.count < limit
  end

  def self.create_menu_section!(menu)
    raise AuthorizationError unless create_menu_section?(menu)
  end

  def self.create_menu_item?(menu)
    limit = menu.business.subscribed? ? 1000 : 10
    menu.menu.menu_items.count < limit
  end

  def self.create_menu_item!(menu)
    raise AuthorizationError unless create_menu_item?(menu)
  end

end
