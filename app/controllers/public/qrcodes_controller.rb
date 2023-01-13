class Public::QrcodesController < Public::ApplicationController
  def show
    qrcode = RQRCode::QRCode.new(params[:url])
    render body: qrcode.as_svg, content_type: "image/svg+xml"
  end
end
