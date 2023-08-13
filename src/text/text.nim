import raylib

var font: Font
var initialized = false

proc initFont*(fileLocation: string) =
  if initialized:
    raise newException(AccessViolationError, "Attempted to load the font more than once!")
  font = loadFont(fileLocation)

proc getFont*: Font = font
