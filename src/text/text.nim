import raylib
import std/math
import ../noml/vector2f

#[
  This is basically like OpenGL API for Raylib Fonts.
  Very stateful, very explicit, hopefully removes bugs down the line.
]#
var font: Font
var initialized = false
var fontSize = 32.0
var color = White
var position = newVector2f(0,0)
var spacing = 2.0
var shadowOffset = newVector2f(2,2)
var shadowColor = Blue
var shadowsEnabled = true

proc initFont*(fileLocation: string) =
  if initialized:
    raise newException(AccessViolationDefect, "Attempted to load the font more than once!")
  font = loadFont(fileLocation, 128, 250)
  setTextureFilter(font.texture, TextureFilter.Anisotropic16x)
  initialized = true

#[
  A puppet object.
  Mimics static classes in Java & modules imports as object in D.
]#
type
  TextObj = object of RootObj

var Text* = TextObj()

# These are made like this so you can chain them together.
proc setSize*(obj: TextObj, size: float): TextObj {.discardable.} =
  fontSize = size
  obj

proc setColor*(obj: TextObj, newColor: Color): TextObj {.discardable.} =
  color = newColor
  obj

proc setPosition*(obj: TextObj, newPosition: Vector2f): TextObj {.discardable.} =
  position.set(newPosition)
  obj

proc setPosition*(obj: TextObj, x,y: float): TextObj {.discardable.} =
  position.set(x,y)
  obj

proc setSpacing*(obj: TextObj, newSpacing: float): TextObj {.discardable.} =
  spacing = newSpacing
  obj

proc setShadowOffset*(obj: TextObj, newOffset: Vector2f): TextObj {.discardable.} =
  shadowOffset.set(newOffset)
  obj

proc setShadowOffset*(obj: TextObj, x,y: float): TextObj {.discardable.} =
  shadowOffset.set(x,y)
  obj

proc setShadowColor*(obj: TextObj, color: Color): TextObj {.discardable.} =
  shadowColor = color
  obj

proc enableShadow*(obj: TextObj): TextObj {.discardable.} =
  shadowsEnabled = true
  obj

proc disableShadow*(obj: TextObj): TextObj {.discardable.} =
  shadowsEnabled = false
  obj

#[
  Passthroughs
]#

# Draw text (using default font)
proc textDraw*(text: string, posX: float, posY: float, fontSize: float, color: Color) =
  drawText(text, int32 floor posX, int32 floor posY, int32 floor fontSize, color)

# Draw text using font and additional parameters
proc textDraw*(text: string, position: Vector2f, fontSize: float, spacing: float, tint: Color) =
  drawText(font, text, position, fontSize, spacing, tint)
  
# Draw text using Font and pro parameters (rotation)
proc textDraw*(text: string, position: Vector2f, origin: Vector2f, rotation: float, fontSize: float, spacing: float, tint: Color) =
  drawText(font, text, position, origin, rotation, fontSize, spacing, tint)


#[
  Custom text drawing components.
]#

# OpenGL style stateful drawing component
proc textDraw*(text: string) =
  if shadowsEnabled:
    textDraw(text, position + shadowOffset, fontSize, spacing, shadowColor)
  textDraw(text, position, fontSize, spacing, color)

proc textDraw*(text: string, newPosition: Vector2f) =
  Text.setPosition(newPosition)
  if shadowsEnabled:
    textDraw(text, position + shadowOffset, fontSize, spacing, shadowColor)
  textDraw(text, position, fontSize, spacing, color)

proc textDraw*(text: string, x,y: float) =
  Text.setPosition(x,y)
  if shadowsEnabled:
    textDraw(text, position + shadowOffset, fontSize, spacing, shadowColor)
  textDraw(text, position, fontSize, spacing, color)
  

#[
  These ones draw the text centered on the X axis.
]#
proc textDrawCentered*(text: string) =
  #font: Font, text: cstring, fontSize: float32, spacing: float32)
  var offset = measureText(font, text, fontSize, spacing).x / 2.0
  textDraw(text, position.getX() - offset, position.getY())

proc textDrawCentered*(text: string, newPosition: Vector2f) =
  position.set(newPosition)
  textDrawCentered(text)

proc textDrawCentered*(text: string, x,y: float) =
  position.set(x,y)
  textDrawCentered(text)