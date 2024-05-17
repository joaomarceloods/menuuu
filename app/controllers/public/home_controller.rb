class Public::HomeController < Public::ApplicationController
  def index
    @menu = Business.first.menus.first
    @qrcode = RQRCode::QRCode.new(public_menu_url(@menu))
  end
end
