class Public::QrcodesController < Public::ApplicationController
  def show
    expires_in 24.hours, public: true
    if stale?(params[:url])
      qrcode = RQRCode::QRCode.new(params[:url])
      render body: qrcode.as_svg(use_path: true), content_type: "image/svg+xml"
    end
  end
end
