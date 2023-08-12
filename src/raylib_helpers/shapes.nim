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

proc getHeight*(r: Rectangle): float =
  return r.height

proc getSize*(r: Rectangle): Vector2f =
  return newVector2f(r.width, r.height)

proc getPosition*(r: Rectangle): Vector2f =
  return newVector2f(r.x, r.y)

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