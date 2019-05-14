require_relative 'generate_interface'

require 'rqrcode'

class QRGenerator
  include Generator

  def generate(phrase)
    qrcode = RQRCode::QRCode.new(phrase)
    qrcode.to_s.gsub(/x/, '#')
  end

end

