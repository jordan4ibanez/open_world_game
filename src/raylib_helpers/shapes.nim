import raylib

#[
  Automatic heap allocations.
]#
type RectangleRef* = ref Rectangle

#[
  Functional constructors.
]#
proc newRectangle*(x,y,width,height: float): RectangleRef =
  result =  RectangleRef(x: x, y: y, width: width, height: height)

#[
  Automatic raylib rectangle converters.
]#
converter toRectangle*(rect: RectangleRef): raylib.Rectangle {.inline.} =
  rect[]
converter toRectangleRef*(rect: Rectangle): RectangleRef {.inline.} =
  new(result)
  result[] = rect