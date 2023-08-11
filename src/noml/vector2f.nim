import std/math
import raylib

type
  Vector2f* = ref object of RootObj
    x: float = 0
    y: float = 0

proc getX*(v: Vector2f): float =
  return v.x

proc getY*(v: Vector2f): float =
  return v.y

proc get*(v: Vector2f): (float, float) =
  return (v.x, v.y)

proc setX*(v: Vector2f, x: float): Vector2f {.discardable.} =
  v.x = x
  return v

proc setY*(v: Vector2f, y: float): Vector2f {.discardable.} =
  v.y = y
  return v

proc set*(v: Vector2f, x,y: float): Vector2f =
  v.x = x
  v.y = y
  return v

proc set*(v, other: Vector2f): Vector2f {.discardable.} =
  v.x = other.x
  v.y = other.y
  return v

proc `-`*(v, other: Vector2f): Vector2f =
  result.set(
    v.x - other.x,
    v.y - other.y
  )

proc `-`*(v, other, output: Vector2f): Vector2f =
  return output.set(
    v.x - other.x,
    v.y - other.y
  )

proc `+`*(v, other: Vector2f): Vector2f =
  result.set(
    v.x + other.x,
    v.y + other.y
  )

proc `+`*(v, other, output: Vector2f): Vector2f =
  return output.set(
    v.x + other.x,
    v.y + other.y
  )

proc `*`*(v, other: Vector2f): Vector2f =
  result.set(
    v.x * other.x,
    v.y * other.y
  )

proc `*`*(v, other, output: Vector2f): Vector2f =
  return output.set(
    v.x * other.x,
    v.y * other.y
  )

proc `==`*(v,other: Vector2f): bool =
  return v.x == other.x and v.y == other.y

proc distance*(v, other: Vector2f): float =
  let distanceX = v.x - other.x
  let distanceY = v.y - other.y
  result = sqrt( distanceX * distanceX + distanceY * distanceY)

proc `$`*(v: Vector2f): string =
  return "Vector2f(" & $v.x & ", " & $v.y & ")"

proc newVector2f*(x,y: float): Vector2f =
  return Vector2f(x: x, y: y)

#[
  Automatic raylib vector2 converters.
]#
converter toVector2*(x: Vector2f): raylib.Vector2 {.inline.} =
  cast[raylib.Vector2](x)

converter fromVector2*(x: raylib.Vector2): Vector2f {.inline.} =
  cast[Vector2f](x)
