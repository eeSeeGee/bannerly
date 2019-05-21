#!/usr/bin/env ruby

require 'chunky_png'

fileBase = 'qr'
outDir = ARGV[0]

def writeQuarter(png, rStart, cStart, mark)
  for r in 0..31 do
    for c in 0..31 do
      png[cStart + c, rStart + r] = ChunkyPNG::Color(mark ? 'black' : 'white')
    end
  end
end

for i in 0..15 do
  fileName = "#{outDir}/#{fileBase}#{i + 1}.png"
  png = ChunkyPNG::Image.new(64, 64)

  writeQuarter(png, 0, 0, i & 1 == 1)
  writeQuarter(png, 0, 31, i >> 1 & 1 == 1)
  writeQuarter(png, 31, 0, i >> 2 & 1 == 1)
  writeQuarter(png, 31, 31, i >> 3 & 1 == 1)

  png.save(fileName, :interlace => true)
end

