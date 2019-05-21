require 'test/unit'

require_relative '../generators/qr_generator'

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

end

