require 'test/unit'

require_relative '../banner/banner_data'
require_relative '../generators/figlet_generator'

class TC_BannerData < Test::Unit::TestCase

  def test_default
    banner = BannerData.new(generate("hello"))
    execTest(banner, "defaulttest.txt")
  end

  def test_stg
    banner = BannerData.new(generate("hello"), ["aaa"], ["stg:3:3"])
    execTest(banner, "stgtest.txt")
  end

  def test_stg_text
    banner = BannerData.new(generate("kiss"), ["stg:3:3"], ["moneybag"])
    execTest(banner, "stgtexttest.txt")
  end

  def test_stg_no_border
    banner = BannerData.new(generate("hello"), ["aaa"], ["stg:3:3"], 0, false)
    execTest(banner, "stgtestnoborder.txt")
  end

  def test_kash
    banner = BannerData.new(generate("hello"), ["aaa"], ["kash"])
    execTest(banner, "kashtest.txt")
  end

  def test_grid
    banner = BannerData.new(generate("kiss"), ["kiss"], ["black_square", "white_square"])
    execTest(banner, "gridtest.txt")
  end

  def test_triple_grid
    banner = BannerData.new(generate("kiss"), ["kiss"], ["black_square", "white_square", "square"])
    execTest(banner, "triplegridtest.txt")
  end

  def test_big_grid
    banner = BannerData.new(generate("kiss"), ["kiss"], ["stg:3:3", "big-thinking-:4:4"])
    execTest(banner, "biggridtest.txt")
  end

  def test_text_grid
    banner = BannerData.new(generate("hello"), ["white_square", "black_square"])
    execTest(banner, "gridtexttest.txt")
  end

  def test_offset_bg
    banner = BannerData.new(generate("hello"), ["parrot"], ["parrot-wave:7"], 1)
    execTest(banner, "offsetbgtest.txt")
  end

  def test_offset_grid_bg
    banner = BannerData.new(generate("cash"), ["parrot-fast"], ["cashalpha-c", "cashalpha-a", "cashalpha-s", "cashalpha-h"], 1)
    execTest(banner, "offsetgridtest.txt")
  end

  def execTest(banner, wantFile)
    want = File.read("../../testdata/#{wantFile}")
    got = banner.output
    assert_equal(want, got)
  end

  def generate(phrase)
    if @generator.nil? then
      @generator = FigletGenerator.new
    end
    @generator.generate(phrase)
  end

end

