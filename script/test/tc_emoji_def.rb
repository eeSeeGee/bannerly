require 'test/unit'

require_relative '../banner/emoji_def'

class TC_EmojiDef < Test::Unit::TestCase

  def test_basic
    emojiDef = EmojiDef.new("basic")
    assert_equal(":basic:", emojiDef.write(0, 0))
    assert_equal(":basic:", emojiDef.write(1, 0))
    assert_equal(":basic:", emojiDef.write(0, 1))
    assert_equal(":basic:", emojiDef.write(1, 1))
  end

  def test_array
    emojiDef = EmojiDef.new("parrot:7")
    assert_equal(":parrot1:", emojiDef.write(0, 0))
    assert_equal(":parrot2:", emojiDef.write(0, 1))
    assert_equal(":parrot5:", emojiDef.write(0, 4))
    assert_equal(":parrot1:", emojiDef.write(0, 7))
    assert_equal(":parrot1:", emojiDef.write(1, 0))
  end

  def test_grid
    emojiDef = EmojiDef.new("stg:3:3")
    assert_equal(":stg11:", emojiDef.write(0, 0))
    assert_equal(":stg12:", emojiDef.write(0, 1))
    assert_equal(":stg11:", emojiDef.write(0, 3))
    assert_equal(":stg22:", emojiDef.write(1, 1))
    assert_equal(":stg31:", emojiDef.write(2, 0))
    assert_equal(":stg33:", emojiDef.write(2, 2))
    assert_equal(":stg13:", emojiDef.write(3, 2))
  end

  def test_grid_with_mid
    emojiDef = EmojiDef.new("stg:3-:3")
    assert_equal(":stg1-1:", emojiDef.write(0, 0))
    assert_equal(":stg1-2:", emojiDef.write(0, 1))
    assert_equal(":stg1-1:", emojiDef.write(0, 3))
    assert_equal(":stg2-2:", emojiDef.write(1, 1))
    assert_equal(":stg3-1:", emojiDef.write(2, 0))
    assert_equal(":stg3-3:", emojiDef.write(2, 2))
    assert_equal(":stg1-3:", emojiDef.write(3, 2))
  end

end

