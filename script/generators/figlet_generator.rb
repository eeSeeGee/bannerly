require_relative 'generate_interface'

class FigletGenerator
  include Generator

  def initialize(vertical = false)
    @vertical = vertical
  end

  def generate(phrase)
    if !@vertical
      return `figlet -f banner #{phrase}`
    end

    figs = []
    maxWidth = 0
    phrase.split('').each { |c|
      fig = `figlet -f banner #{c}`
      maxWidth = [maxWidth, blockWidth(fig)].max
      figs.push(fig)
    }

    output = ''
    for fig in figs do
      width = blockWidth(fig)
      if width < maxWidth
        beginWidth = (maxWidth - width) / 2
        endWidth = maxWidth - width - beginWidth
        beg = padding(beginWidth)
        ed = padding(endWidth)
        fig = fig.gsub(/^([^\n]*)\n/, "#{beg}\\1#{ed}\n")
      end
      output << fig
    end
    output.gsub(/^( +\n)^ +\n/, '\1')
  end

  def blockWidth(fig)
    first = fig.match(/^([^\n]*\n)/)[0]
    first.length
  end

  def padding(width)
    pad = ''
    for x in 1..width do
      pad << ' '
    end
    pad
  end
end

