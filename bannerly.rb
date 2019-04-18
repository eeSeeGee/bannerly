#!/usr/bin/env ruby

require 'optparse'

class BannerData
  def initialize(opts, phrase)
    @width = opts[:width]
    @height = opts[:height]
    @textbg = opts[:text]
    @bg = opts[:bg]
    @grid = opts[:grid]
    @border = opts[:border]

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
    if @border
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
    print ":#{@textbg}:"
  end

  def printBack
    if !@grid.nil? and @row % 2 == @col % 2
      print ":#{@grid}:"
      return
    end

    if @width == 0 or @height == 0
      fill = ''
    else
      fill = "#{@row % @height + 1}#{@col % @width + 1}"
    end
    print ":#{@bg}#{fill}:"
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

      if @border and @col == 0
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

$opts = {
  :width => 0,
  :height => 0,
  :text => "partyparrot",
  :bg => "cash",
  :grid => nil,
  :border => true,
}

OptionParser.new do |opts|
  opts.on("--width <WIDTH>", "How wide the banner bigemoji is.") do |v|
    $opts[:width] = v.to_i
  end
  opts.on("--height <HEIGHT>", "How high the banner bigemoji is.") do |v|
    $opts[:height] = v.to_i
  end
  opts.on("--text <TEXT_EMOJI>", "Which emoji to use for the text.") do |v|
    $opts[:text] = v.gsub(/:/, '')
  end
  opts.on("--bg <BG_EMOJI>", "Which emoji to use for the background.") do |v|
    $opts[:bg] = v.gsub(/:/, '')
  end
  opts.on("--grid <GRID_EMOJI>", "Which emoji to use for the background in grid mode.") do |v|
    $opts[:grid] = v.gsub(/:/, '')
  end
  opts.on("--noborder", "Remove the margin.") do |v|
    $opts[:border] = false
  end
end.parse!

banner = BannerData.new($opts, ARGV.join(" "))
banner.output

