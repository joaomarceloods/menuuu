class Public::QrcodesController < Public::ApplicationController
  def show
    expires_in 24.hours, public: true
    if stale?(params[:menu_id])
      qrcode = RQRCode::QRCode.new(public_menu_url(params[:menu_id]))
      render body: qrcode.as_svg(use_path: true), content_type: "image/svg+xml"
    end
  end
end
