import raylib
import ../noml/vector2f
import ../camera/camera

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
    scrollDelta: Vector2f

proc update*(mouse: MouseObj) =
  mouse.pos = getMousePosition()
  mouse.leftClick = isMouseButtonPressed(Left)
  mouse.rightClick = isMouseButtonPressed(Right)
  mouse.leftHeld = isMouseButtonDown(Left)
  mouse.rightHeld = isMouseButtonDown(Right)
  mouse.scrollDelta.set(getMouseWheelMoveV())

# Window cursor position.
proc getPosition*(mouse: MouseObj): Vector2f =
  return mouse.pos

proc getX*(mouse: MouseObj): float =
  return mouse.pos.getX()

proc getY*(mouse: MouseObj): float =
  return mouse.pos.getY()

# World map cursor position.
proc getWorldPosition*(mouse: MouseObj): Vector2f =
  getScreenToWorld2D(mouse.pos, Cam)

proc getWorldX*(mouse: MouseObj): float =
  getWorldPosition(mouse).getX

proc getWorldY*(mouse: MouseObj): float =
  getWorldPosition(mouse).getX

proc leftClicked*(mouse: MouseObj): bool =
  return mouse.leftClick

proc rightClicked*(mouse: MouseObj): bool =
  return mouse.rightClick

proc leftHeld*(mouse: MouseObj): bool =
  return mouse.leftHeld

proc rightHeld*(mouse: MouseObj): bool =
  return mouse.rightHeld

proc getScroll*(mouse: MouseObj): Vector2f =
  return mouse.scrollDelta

proc getScrollX*(mouse: MouseObj): float =
  return mouse.scrollDelta.getX

proc getScrollY*(mouse: MouseObj): float =
  return mouse.scrollDelta.getY

var Mouse* = MouseObj()