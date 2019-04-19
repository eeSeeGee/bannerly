#!/usr/bin/env ruby

require 'optparse'

class EmojiDef
  def initialize(emojiStr)
    @emoji, sp, width, sp2, height = emojiStr.match(/([\w-]+)(:(\d+)(:(\d+))?)?$/).captures
    @width = width.nil? ? nil : width.to_i
    @height = height.nil? ? nil : height.to_i
  end

  def write(row, col)
    fill = ''
    if !@height.nil?
      fill = "#{fill}#{row % @height + 1}"
    end
    if !@width.nil?
      fill = "#{fill}#{col % @width + 1}"
    end
    print ":#{@emoji}#{fill}:"
  end
end

class BannerData
  def initialize(opts, phrase)
    @border = opts[:border]

    @textEmoji = opts[:text].map { |emoji| EmojiDef.new(emoji) }
    if @textEmoji.empty?
      @textEmoji = [EmojiDef.new('poop')]
    end

    @bgEmoji = opts[:bg].map { |emoji| EmojiDef.new(emoji) }
    if @bgEmoji.empty?
      @bgEmoji = [EmojiDef.new('moneybag')]
    end

    @bgOffset = opts[:bgoffset]

    @text = `figlet -f banner #{phrase}`
  end

  def bumpCol
    @col = @col +1
  end

  def bumpRow
    @row = @row + 1
    @col = 0
    @shift = @shift + @bgOffset
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
    printEmoji(@textEmoji)
  end

  def printBack
    printEmoji(@bgEmoji)
  end

  def printEmoji(emoji)
    $size = emoji.size
    $pos = (@row % $size + @col + @shift) % $size
    emoji[$pos].write(@row, @col + @shift)
  end

  def output
    @row = 0
    @col = 0
    @shift = 0

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
  :text => [],
  :bg => [],
  :border => true,
  :bgoffset => 0,
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
end.parse!

banner = BannerData.new($opts, ARGV.join(" "))
banner.output

