require_relative 'generate_interface'

class FigletGenerator
  include Generator

  def generate(phrase)
    `figlet -f banner #{phrase}`
  end
end

