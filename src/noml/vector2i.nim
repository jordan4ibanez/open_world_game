import std/math
import raylib

type
  Vector2i* = object of RootObj
    x: int = 0
    y: int = 0

proc getX*(v: Vector2i): int =
  return v.x

proc getY*(v: Vector2i): int =
  return v.y

proc get*(v: Vector2i): (int, int) =
  return (v.x, v.y)

proc setX*(v: var Vector2i, x: int): Vector2i {.discardable.} =
  v.x = x
  return v

proc setY*(v: var Vector2i, y: int): Vector2i {.discardable.} =
  v.y = y
  return v

proc set*(v: var Vector2i, x,y: int): Vector2i =
  v.x = x
  v.y = y
  return v

proc set*(v: var Vector2i, other: Vector2i): Vector2i {.discardable.} =
  v.x = other.x
  v.y = other.y
  return v

proc `-`*(v: var Vector2i, scalar: int): Vector2i {.discardable.} =
  v.x -= scalar
  v.y -= scalar
  return v

proc `-`*(v, other: Vector2i): Vector2i =
  result.set(
    v.x - other.x,
    v.y - other.y
  )

proc `-`*(v, other: Vector2i, output: var Vector2i): Vector2i =
  return output.set(
    v.x - other.x,
    v.y - other.y
  )

proc `+`*(v: var Vector2i, scalar: int): Vector2i {.discardable.} =
  v.x += scalar
  v.y += scalar
  return v

proc `+`*(v, other: Vector2i): Vector2i =
  result.set(
    v.x + other.x,
    v.y + other.y
  )

proc `+`*(v, other: Vector2i, output: var Vector2i): Vector2i =
  return output.set(
    v.x + other.x,
    v.y + other.y
  )

proc `*`*(v: var Vector2i, scalar: int): Vector2i {.discardable.} =
  v.x *= scalar
  v.y *= scalar
  return v

proc `*`*(v, other: Vector2i): Vector2i =
  result.set(
    v.x * other.x,
    v.y * other.y
  )

proc `*`*(v, other: Vector2i, output: var Vector2i): Vector2i =
  return output.set(
    v.x * other.x,
    v.y * other.y
  )

proc `==`*(v,other: Vector2i): bool =
  return v.x == other.x and v.y == other.y

proc distance*(v, other: Vector2i): float =
  let distanceX = (float)(v.x - other.x)
  let distanceY = (float)(v.y - other.y)
  result = sqrt( distanceX * distanceX + distanceY * distanceY)

proc `$`*(v: Vector2i): string =
  return "Vector2i(" & $v.x & ", " & $v.y & ")"

proc newVector2i*(x,y: int): Vector2i =
  return Vector2i(x: x, y: y)

#[
  Automatic raylib vector2 converters.
]#
converter toVector2*(vec: Vector2i): raylib.Vector2 {.inline.} =
  result = Vector2(x: (float)vec.x, y: (float)vec.y)

converter fromVector2*(vec: raylib.Vector2): Vector2i {.inline.} =
  result = Vector2i(x: (int)vec.x, y: (int) vec.y)
