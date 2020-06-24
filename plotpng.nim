## This script takes a list of colours and a png of a colour spectrum and blacks
## out any pixel that isn't in the list.
import nimPNG, strutils

var colours: array[0x0..0xFFFFFF, bool]

for c in lines("goodcolours.txt"):
  colours[parseHexInt(c.string)] = true

var spectrum = loadPNG24("spectrum.png")
for i in countup(0, spectrum.data.high, 3):
  let c = (spectrum.data[i].int shl 16) or
          (spectrum.data[i+1].int shl 8) or
          spectrum.data[i+2].int
  if not colours[c]:
    spectrum.data[i] = 0.char
    spectrum.data[i+1] = 0.char
    spectrum.data[i+2] = 0.char

echo savePNG24("goodcolours.png", spectrum.data, spectrum.width, spectrum.height)
