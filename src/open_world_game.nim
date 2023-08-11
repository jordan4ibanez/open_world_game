import noml/vector2f
import entity/entity
import std/strutils
import utils/print
import raylib
import raylib_helpers/shapes

var running: bool = true


#[
  Game entry point, init, loop, and exit.
]#
proc initialize =
  initWindow(800, 600, "Hello")
  setTargetFPS(60)


proc mainLoop =
  # Update procedure.

  var person = RectangleRef(x: 100, y: 100, width: 220, height: 220)


  # Draw procedure.
  beginDrawing()
  clearBackground(Black)
  drawText("hi", 0,0,32, RayWhite)
  drawRectangle(person, Red)
  endDrawing()


proc cleanUp =
  closeWindow()



#[
  The above functional processes implemented in a nim-friendly manor.
  Condensed into this mini blob.
]#
proc main =
  initialize()
  while not windowShouldClose():
    mainLoop()
  cleanUp()
main()