import noml/vector2f
import std/math
import std/strutils
import entity/entity
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


  # Draw procedure.
  beginDrawing()
  clearBackground(Black)
  drawText("hi", 0,0,32, RayWhite)


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