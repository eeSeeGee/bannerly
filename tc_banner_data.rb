require 'test/unit'

require_relative 'banner_data'

class TC_BannerData < Test::Unit::TestCase

  def test_default
    banner = BannerData.new("hello")
    execTest(banner, "defaulttest.txt")
  end

  def test_stg
    banner = BannerData.new("hello", ["aaa"], ["stg:3:3"])
    execTest(banner, "stgtest.txt")
  end

  def test_stg_text
    banner = BannerData.new("kiss", ["stg:3:3"], ["moneybag"])
    execTest(banner, "stgtexttest.txt")
  end

  def test_stg_no_border
    banner = BannerData.new("hello", ["aaa"], ["stg:3:3"], 0, false)
    execTest(banner, "stgtestnoborder.txt")
  end

  def test_kash
    banner = BannerData.new("hello", ["aaa"], ["kash"])
    execTest(banner, "kashtest.txt")
  end

  def test_grid
    banner = BannerData.new("kiss", ["kiss"], ["black_square", "white_square"])
    execTest(banner, "gridtest.txt")
  end

  def test_triple_grid
    banner = BannerData.new("kiss", ["kiss"], ["black_square", "white_square", "square"])
    execTest(banner, "triplegridtest.txt")
  end

  def test_big_grid
    banner = BannerData.new("kiss", ["kiss"], ["stg:3:3", "big-thinking-:4:4"])
    execTest(banner, "biggridtest.txt")
  end

  def test_text_grid
    banner = BannerData.new("hello", ["white_square", "black_square"])
    execTest(banner, "gridtexttest.txt")
  end

  def test_offset_bg
    banner = BannerData.new("hello", ["parrot"], ["parrot-wave:7"], 1)
    execTest(banner, "offsetbgtest.txt")
  end

  def test_offset_grid_bg
    banner = BannerData.new("cash", ["parrot-fast"], ["cashalpha-c", "cashalpha-a", "cashalpha-s", "cashalpha-h"], 1)
    execTest(banner, "offsetgridtest.txt")
  end

  def execTest(banner, wantFile)
    want = File.read(wantFile)
    got = banner.output
    assert_equal(want, got)
  end

end

