require 'test/unit'

require_relative '../generators/qr_generator'
require_relative '../generators/qr_quadmode'

class TC_QRGenerator < Test::Unit::TestCase

  def test_basic
    generator = QRGenerator.new
    result = generator.generate('foo')
    assert_equal(
        "####### #  #  #######\n" +
        "#     #    ## #     #\n" +
        "# ### #  # #  # ### #\n" +
        "# ### # ## #  # ### #\n" +
        "# ### #  ## # # ### #\n" +
        "#     #  # ## #     #\n" +
        "####### # # # #######\n" +
        "           ##        \n" +
        "  # ### ##   #   #  #\n" +
        "#    # ####  ##   ###\n" +
        "  #  ## ###     ## ##\n" +
        "######       ##    ##\n" +
        "#    #### ####  #  ##\n" +
        "        # #  # #  ###\n" +
        "#######  ## #  # # ##\n" +
        "#     # #   # ####  #\n" +
        "# ### # #  #####  # #\n" +
        "# ### #    ## #   ## \n" +
        "# ### # ###     #   #\n" +
        "#     #  # ####   ## \n" +
        "#######  # #  # # ###\n", result)
  end

  def test_quadModeBasic
    quadMode = QRQuadMode.new
    result = quadMode.quad(
      "# \n" +
      "# \n"
    )
    assert_equal(":qr6:\n", result)
  end

  def test_quadModeOdd
    quadMode = QRQuadMode.new
    result = quadMode.quad(
      "# #\n" +
      "# #\n" +
      " ##\n"
    )
    assert_equal(":qr6::qr6:\n:qr3::qr2:\n", result)
  end

end

