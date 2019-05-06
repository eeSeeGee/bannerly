require_relative 'emoji_def'

# BannerData renders a string where ' ' is the background and '#' the foreground into Slack emojis.
class BannerData
  def initialize(phrase, textEmojis = [], bgEmojis = [], bgoffset = 0, border = true)
    @border = border

    @textEmoji = textEmojis.map { |emoji| EmojiDef.new(emoji) }
    if @textEmoji.empty?
      @textEmoji = [EmojiDef.new('poop')]
    end

    @bgEmoji = bgEmojis.map { |emoji| EmojiDef.new(emoji) }
    if @bgEmoji.empty?
      @bgEmoji = [EmojiDef.new('moneybag')]
    end

    @bgOffset = bgoffset

    @text = phrase
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
        @result = @result + "\n"
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
    @result = @result + emoji[$pos].write(@row, @col + @shift)
  end

  def output
    @row = 0
    @col = 0
    @shift = 0
    @result = ""

    printTopBorder

    @text.split('').each { |c|
      if c == "\n"
        bumpRow
        @result = @result + "\n"
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

    @result
  end
end

