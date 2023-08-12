import raylib
import ../noml/vector2f

#[
  Mouse is an abstraction built on top of the Raylib base struct for ease of use.
  It may seem pointless to encapsulate this data like this, but it makes it easier to work with.
]#
type
  MouseObj = ref object of RootObj
    pos: Vector2f
    leftClick: bool
    rightClick: bool
    leftHeld: bool
    rightHeld: bool

proc update*(mouse: MouseObj) =
  mouse.pos = getMousePosition()
  mouse.leftClick = isMouseButtonPressed(Left)
  mouse.rightClick = isMouseButtonPressed(Right)
  mouse.leftHeld = isMouseButtonDown(Left)
  mouse.rightHeld = isMouseButtonDown(Right)

proc getPosition*(mouse: MouseObj): Vector2f =
  return mouse.pos

proc getX*(mouse: MouseObj): float =
  return mouse.pos.getX()

proc getY*(mouse: MouseObj): float =
  return mouse.pos.getY()

proc leftClicked*(mouse: MouseObj): bool =
  return mouse.leftClick

proc rightClicked*(mouse: MouseObj): bool =
  return mouse.rightClick

proc leftHeld*(mouse: MouseObj): bool =
  return mouse.leftHeld

proc rightHeld*(mouse: MouseObj): bool =
  return mouse.rightHeld

var Mouse* = MouseObj()