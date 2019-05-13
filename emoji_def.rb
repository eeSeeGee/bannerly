class EmojiDef
  def initialize(emojiStr)
    @emoji, sp, width, @mid, sp2, height = emojiStr.match(/([\w-]+)(:(\d+)([\w-]+)?(:(\d+))?)?$/).captures
    @width = width.nil? ? nil : width.to_i
    @height = height.nil? ? nil : height.to_i
  end

  def write(row, col)
    fill = ''
    if !@height.nil?
      fill = "#{fill}#{row % @height + 1}"
    end

    if !@mid.nil?
      fill << @mid
    end

    if !@width.nil?
      fill = "#{fill}#{col % @width + 1}"
    end
    ":#{@emoji}#{fill}:"
  end

  def width
    return @width.nil? ? 1 : @width
  end

  def height
    return @height.nil? ? 1 : @height
  end

end

