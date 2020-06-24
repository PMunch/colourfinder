## This script reads the languages.yml file from linguist and generates a list
## of all colours which would qualify for a new colour based on their
## test_colour_proximity test. This isn't a very efficient way of doing it, as
## it parses strings into colour objects for every single colour combination.
import color_distance, yaml, streams, tables, strutils

let
  s = newFileStream("languages.yml")
  p = loadDOM(s)

var colours: seq[string]
for key, value in p.root.fields:
  try:
    colours.add value["color"].content[1..^1]
  except: discard

var
  coloursFile = open("goodcolours.txt", fmWrite)
  count = 0
for i in 0x0..0xFFFFFF:
  let colour = i.toHex(6)
  var accepted = true
  for c in colours:
    if deltaE00(colour, c) / 100 < 0.05:
      accepted = false
      break
  if accepted:
    coloursFile.writeLine colour
    inc count
  if i mod 10_000 == 0:
    echo int((i/0xFFFFFF) * 100), "% rejected colours: ", i - count, " accepted colours: ", count

echo count
coloursFile.close
