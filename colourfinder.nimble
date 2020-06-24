# Package

version       = "0.1.0"
author        = "PMunch"
description   = "Create nice spectrum images of colours"
license       = "MIT"
srcDir        = "src"
bin           = @["colourfinder"]



# Dependencies

requires "nim >= 1.2.2"
requires "nimPNG"
requires "color_distance"
requires "yaml"

task createlist, "Create the list of accepted colours":
  exec "nim c -d:release -d:danger -r findcolours.nim"

task createspectrum, "Creates the spectrum image of the accepted colours":
  exec "nim c -d:release -d:danger -r plotpng.nim"

