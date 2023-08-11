import std/math

type
  Vector2i* = ref object of RootObj
    x: int = 0
    y: int = 0

proc getX*(v: Vector2i): int =
  return v.x

proc getY*(v: Vector2i): int =
  return v.y

proc get*(v: Vector2i): (int, int) =
  return (v.x, v.y)

proc setX*(v: Vector2i, x: int): Vector2i {.discardable.} =
  v.x = x
  return v

proc setY*(v: Vector2i, y: int): Vector2i {.discardable.} =
  v.y = y
  return v

proc set*(v: Vector2i, x,y: int): Vector2i =
  v.x = x
  v.y = y
  return v

proc set*(v, other: Vector2i): Vector2i {.discardable.} =
  v.x = other.x
  v.y = other.y
  return v

proc subtract*(v, other: Vector2i): Vector2i =
  result.set(
    v.x - other.x,
    v.y - other.y
  )

proc subtract*(v, other, output: Vector2i): Vector2i =
  return output.set(
    v.x - other.x,
    v.y - other.y
  )

proc add*(v, other: Vector2i): Vector2i =
  result.set(
    v.x + other.x,
    v.y + other.y
  )

proc add*(v, other, output: Vector2i): Vector2i =
  return output.set(
    v.x + other.x,
    v.y + other.y
  )

proc multiply*(v, other: Vector2i): Vector2i =
  result.set(
    v.x * other.x,
    v.y * other.y
  )

proc multiply*(v, other, output: Vector2i): Vector2i =
  return output.set(
    v.x * other.x,
    v.y * other.y
  )

proc distance*(v, other: Vector2i): float =
  let distanceX = (float)(v.x - other.x)
  let distanceY = (float)(v.y - other.y)
  result = sqrt( distanceX * distanceX + distanceY * distanceY)


proc `$`*(v: Vector2i): string =
  return "Vector2i(" & $v.x & ", " & $v.y & ")"

proc newVector2i*(x,y: int): Vector2i =
  return Vector2i(x: x, y: y)