import raylib
import ../noml/vector2f

#[
  Automatic heap allocations.
]#
type RectangleRef* = ref Rectangle

#[
  Functional constructors.
]#
proc newRectangle*(x,y,width,height: float): Rectangle =
  result = Rectangle(x: x, y: y, width: width, height: height)

proc newRectangle*(pos,size: Vector2f): Rectangle =
  result = Rectangle(x: pos.getX(), y: pos.getY(), width: size.getX(), height: size.getY())

proc newRectangle*(pos: Vector2f, width,height: float): Rectangle =
  result = Rectangle(x: pos.getX(), y: pos.getY(), width: width, height: height)

proc newRectangle*(x,y: float,size: Vector2f): Rectangle =
  result = Rectangle(x: x, y: y, width: size.getX(), height: size.getY())

#[
  Rectangle methods
]#
proc getWidth*(r: Rectangle): float =
  return r.width

proc setWidth*(r: var Rectangle, width: float) =
  r.width = width

proc getHeight*(r: Rectangle): float =
  return r.height

proc setHeight*(r: var Rectangle, height: float) =
  r.height = height

proc getSize*(r: Rectangle): Vector2f =
  return newVector2f(r.width, r.height)

proc setSize*(r: var Rectangle, size: Vector2f) =
  r.width = size.getX()
  r.height = size.getY()

proc setSize*(r: var Rectangle, x,y: float) =
  r.width = x
  r.height = y

proc getPosition*(r: Rectangle): Vector2f =
  return newVector2f(r.x, r.y)

proc setPosition*(r: var Rectangle, position: Vector2f) =
  r.x = position.getX()
  r.y = position.getY()

proc setPosition*(r: var Rectangle, x,y: float) =
  r.x = x
  r.y = y

proc getCenter*(r: Rectangle): Vector2f =
  return r.getSize / 2.0

#[
  Automatic raylib rectangle converters.
]#
converter toRectangle*(rect: RectangleRef): raylib.Rectangle {.inline.} =
  rect[]
converter toRectangleRef*(rect: Rectangle): RectangleRef {.inline.} =
  new(result)
  result[] = rect