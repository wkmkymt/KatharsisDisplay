module UsersHelper
  require 'rqrcode'
  require 'rqrcode_png'
  require 'chunky_png'

  def qrcode(text)
    qr = RQRCode::QRCode.new(text)
    png = qr.as_png.resize(500,500).to_datastream
    ChunkyPNG::Image.from_datastream(png).to_data_url
  end
end
