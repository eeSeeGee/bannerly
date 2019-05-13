#!/usr/bin/env ruby

require 'optparse'

require_relative 'banner_data'
require_relative 'figlet_generator'
require_relative 'banner_generator'

$opts = {
  :text => [],
  :bg => [],
  :border => true,
  :bgoffset => 0,
  :bannermode => false
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
  opts.on("--bgoffset <OFFSET>", "Shift the start position of each row by this many spaces (accumulating).") do |v|
    $opts[:bgoffset] = v.to_i
  end
  opts.on("--bannermode", "Print only the background emojis, using the full size of bigemojis.") do |v|
    $opts[:bannermode] = true
    $opts[:border] = false
  end
end.parse!

if $opts[:bannermode] then
  generator = BannerGenerator.new($opts[:bg], $opts[:bgoffset] > 0)
else
  generator = FigletGenerator.new
end

banner = BannerData.new(generator.generate(ARGV.join(" ")), $opts[:text], $opts[:bg], $opts[:bgoffset], $opts[:border])
print banner.output

