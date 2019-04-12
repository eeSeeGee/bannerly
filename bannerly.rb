#!/usr/bin/env ruby

require 'optparse'

class BannerData
  def initialize(phrase)
    @text = `figlet -f banner #{phrase}`
  end

  def bumpCol
    @col = @col +1
  end

  def bumpRow
    @row = @row + 1
    @col = 0
  end

  def printTopBorder
    if $global_opts[:border]
      found = false
      count = 1
      @text.split('').each { |c|
        if c == '#'
          found = true
        elsif c == "\n"
          break
        end
        count = count + 1
      }

      if found
        (1..count).each do |i|
          printBack
          bumpCol
        end
        print "\n"
        bumpRow
      end
    end
  end

  def printText
    print ":#{$global_opts[:text]}:"
  end

  def printBack
    if !$global_opts[:grid].nil? and @row % 2 == @col % 2
      print ":#{$global_opts[:grid]}:"
      return
    end

    if $global_opts[:width] == 0 or $global_opts[:height] == 0
      fill = ''
    else
      fill = "#{@row % $global_opts[:height] + 1}#{@col % $global_opts[:width] + 1}"
    end
    print ":#{$global_opts[:bg]}#{fill}:"
  end

  def output
    @row = 0
    @col = 0

    printTopBorder

    @text.split('').each { |c|
      if c == "\n"
        bumpRow
        print "\n"
        next
      end

      if $global_opts[:border] and @col == 0
        printBack
        bumpCol
      end

      if c == '#'
        printText
      elsif c == ' '
        printBack
      end

      bumpCol
    }
  end
end

$global_opts = {
  :width => 0,
  :height => 0,
  :text => "partyparrot",
  :bg => "cash",
  :grid => nil,
  :border => true,
}

OptionParser.new do |opts|
  opts.on("--width <WIDTH>", "How wide the banner bigemoji is.") do |v|
    $global_opts[:width] = v.to_i
  end
  opts.on("--height <HEIGHT>", "How high the banner bigemoji is.") do |v|
    $global_opts[:height] = v.to_i
  end
  opts.on("--text <TEXT_EMOJI>", "Which emoji to use for the text.") do |v|
    $global_opts[:text] = v.gsub(/:/, '')
  end
  opts.on("--bg <BG_EMOJI>", "Which emoji to use for the background.") do |v|
    $global_opts[:bg] = v.gsub(/:/, '')
  end
  opts.on("--grid <GRID_EMOJI>", "Which emoji to use for the background in grid mode.") do |v|
    $global_opts[:grid] = v.gsub(/:/, '')
  end
  opts.on("--noborder", "Remove the margin.") do |v|
    $global_opts[:border] = false
  end
end.parse!

banner = BannerData.new(ARGV.join(" "))
banner.output

