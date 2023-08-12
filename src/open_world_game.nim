import noml/vector2f

import std/math
import std/strutils
import camera/camera
import entity/entity
import utils/print
import raylib
import raylib_helpers/shapes

var running: bool = true


#[
  Game entry point, init, loop, and exit.
]#
proc initialize =
  setConfigFlags(flags(WindowResizable))
  initWindow(800, 600, "Hello")
  setTargetFPS(60)


var yaw = 0.0

proc mainLoop =
  # Update procedure.

  yaw += 10

  # Draw procedure.
  beginDrawing()
  Cam.update()
  beginMode2D(Cam)
  clearBackground(Black)
  drawText("hi", 0,0,32, RayWhite)

  let rectangle = newRectangle(SinglePlayer.getPosition(),100,200)
  
  drawRectangle(rectangle, rectangle.getCenter(), yaw, Red)

  endMode2D()
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