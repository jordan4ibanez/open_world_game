type
  Vector2i* = ref object of RootObj
    x: int = 0
    y: int = 0

proc getX*(v: Vector2i): int =
  return v.x

proc getY*(v: Vector2i): int =
  return v.y

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

proc toString*(v: Vector2i): string =
  return "Vector2i(" & $v.x & ", " & $v.y & ")"