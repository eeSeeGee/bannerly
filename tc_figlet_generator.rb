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

  def test_vertical
    generator = FigletGenerator.new(true)
    result = generator.generate('foo')
    assert_equal(
      "       \n" +
      "###### \n" +
      "#      \n" +
      "#####  \n" +
      "#      \n" +
      "#      \n" +
      "#      \n" +
      "       \n" +
      " ####  \n" +
      "#    # \n" +
      "#    # \n" +
      "#    # \n" +
      "#    # \n" +
      " ####  \n" +
      "       \n" +
      " ####  \n" +
      "#    # \n" +
      "#    # \n" +
      "#    # \n" +
      "#    # \n" +
      " ####  \n" +
      "       \n", result)
  end

  def test_skinny_vertical
    generator = FigletGenerator.new(true)
    result = generator.generate('hi')
    assert_equal(
      "       \n" +
      "#    # \n" +
      "#    # \n" +
      "###### \n" +
      "#    # \n" +
      "#    # \n" +
      "#    # \n" +
      "       \n" +
      "  #    \n" +
      "  #    \n" +
      "  #    \n" +
      "  #    \n" +
      "  #    \n" +
      "  #    \n" +
      "       \n", result)
  end

end

