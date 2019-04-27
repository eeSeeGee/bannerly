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
    ":#{@emoji}#{fill}:"
  end
end

