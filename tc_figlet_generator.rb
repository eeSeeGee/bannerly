require 'test/unit'

require_relative 'figlet_generator'

class TC_FigletGenerator < Test::Unit::TestCase

  def test_basic
    generator = FigletGenerator.new
    result = generator.generate('foo')
    assert_equal(
      "                     \n" +
      "######  ####   ####  \n" +
      "#      #    # #    # \n" +
      "#####  #    # #    # \n" +
      "#      #    # #    # \n" +
      "#      #    # #    # \n" +
      "#       ####   ####  \n" +
      "                     \n", result)
  end

end

