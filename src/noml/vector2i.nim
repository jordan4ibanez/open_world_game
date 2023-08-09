type
  Vector2i* = ref object of RootObj
    x: int = 0
    y: int = 0

proc getX*(v: Vector3i): int =
  return v.x

proc getY*(v: Vector3i): int =
  return v.y

proc setX*(v: Vector3i, x: int): Vector3i {.discardable.} =
  v.x = x
  return v

proc setY*(v: Vector3i, y: int): Vector3i {.discardable.} =
  v.y = y
  return v



