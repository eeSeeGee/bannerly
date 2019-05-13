require 'test/unit'

require_relative 'banner_generator'

class TC_BannerGenerator < Test::Unit::TestCase

  def test_banner
    generator = BannerGenerator.new(['stg:3:3'])
    result = generator.generate('')
    assert_equal(
      "   \n" +
      "   \n" +
      "   \n", result)
  end

  def test_line
    generator = BannerGenerator.new(['a', 'b', 'c'])
    result = generator.generate('')
    assert_equal(
      "   \n", result)
  end

  def test_offset
    generator = BannerGenerator.new(['a', 'b', 'c'], true)
    result = generator.generate('')
    assert_equal(
      "   \n" +
      "   \n" +
      "   \n", result)
  end


end

