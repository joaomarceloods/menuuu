class Public::QrcodesController < Public::ApplicationController
  def show
    qrcode = RQRCode::QRCode.new(public_menu_path(params[:business_id]))
    render body: qrcode.as_svg, content_type: "image/svg+xml"
  end
end
