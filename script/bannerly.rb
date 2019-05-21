#!/usr/bin/env ruby

require 'optparse'

require_relative 'banner/banner_data'

require_relative 'generators/figlet_generator'
require_relative 'generators/banner_generator'
require_relative 'generators/qr_generator'

$opts = {
  :text => [],
  :bg => [],
  :vertical => false,
  :border => true,
  :bgoffset => 0,
  :bannermode => false,
  :qrcode => false
}

OptionParser.new do |opts|
  opts.on("--text <TEXT_EMOJI>((:height):width)", "Which emoji to use for the text.") do |v|
    $opts[:text].push(v)
  end
  opts.on("--bg <BG_EMOJI>((:height):width)", "Which emoji to use for the background.") do |v|
    $opts[:bg].push(v)
  end
  opts.on("--noborder", "Remove the margin.") do |v|
    $opts[:border] = false
  end
  opts.on("--vertical", "Print the banner vertically.") do |v|
    $opts[:vertical] = true
  end
  opts.on("--bgoffset <OFFSET>", "Shift the start position of each row by this many spaces (accumulating).") do |v|
    $opts[:bgoffset] = v.to_i
  end
  opts.on("--bannermode", "Print only the background emojis, using the full size of bigemojis.") do |v|
    $opts[:bannermode] = true
    $opts[:border] = false
  end
  opts.on("--qrcode", "Print a QR code.") do |v|
    $opts[:qrcode] = true
  end
end.parse!

if $opts[:bannermode] then
  generator = BannerGenerator.new($opts[:bg], $opts[:bgoffset] > 0)
elsif $opts[:qrcode] then
  generator = QRGenerator.new
else
  generator = FigletGenerator.new($opts[:vertical])
end

banner = BannerData.new(generator.generate(ARGV.join(" ")), $opts[:text], $opts[:bg], $opts[:bgoffset], $opts[:border])
print banner.output

