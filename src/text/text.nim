import raylib

var font: Font
var initialized = false

proc initFont*(fileLocation: string) =
  if initialized:
    raise newException(AccessViolationDefect, "Attempted to load the font more than once!")
  font = loadFont(fileLocation)
  initialized = true

proc getFont*: var Font = font