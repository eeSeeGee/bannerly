require_relative 'generate_interface'
require_relative 'emoji_def'

class BannerGenerator
  include Generator

  def initialize(emojis, bgOffset = false)
    @maxWidth = emojis.size
    @maxHeight = 1

    emojis.each { |emo|
      emojiDef = EmojiDef.new(emo)
      @maxWidth = [emojiDef.width, @maxWidth].max
      @maxHeight = [emojiDef.height, @maxHeight].max
    }

    if bgOffset then
      @maxHeight = [@maxWidth, @maxHeight].max
      @maxWidth = @maxHeight
    end
  end

  def generate(phrase)
    banner = ''
    for r in 1..@maxHeight do
      for c in 1..@maxWidth do
        banner << ' '
      end
      banner << "\n"
    end
    banner
  end
end

