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

proc toString*(v: Vector2i): string =
  return "Vector2i(" & $v.x & ", " & $v.y & ")"