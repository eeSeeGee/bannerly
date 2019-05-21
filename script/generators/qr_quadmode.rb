
class QRQuadMode
  def initialize
    @emojiBase = 'qr'
  end

  def quad(qrString)
    qrMatrix = []
    qrRow = []

    qrString.split('').each { |c|
      if c == "\n"
        qrMatrix.push(qrRow)
        qrRow = []
      else
        qrRow.push(c)
      end
    }

    qrString = ''
    qrSize = qrMatrix[0].size

    for r in 0..qrSize - 1 do
      if r % 2 == 1
        next
      end
      for c in 0..qrSize - 1 do
        if c % 2 == 1
          next
        end
        val = qrMatrix[r][c] == '#' ? 1 : 0
        if c < qrSize - 1
          val = val | (qrMatrix[r][c + 1] == '#' ? 2 : 0)
        end
        if r < qrSize - 1
          val = val | (qrMatrix[r + 1][c] == '#' ? 4 : 0)
        end
        if c < qrSize - 1 and r < qrSize - 1
          val = val | (qrMatrix[r + 1][c + 1] == '#' ? 8 : 0)
        end

        qrString << ":#{@emojiBase}#{val + 1}:"
      end
      qrString << "\n"
    end

    qrString
  end
end

