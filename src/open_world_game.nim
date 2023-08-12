import noml/vector2f

import std/math
import std/strutils
import camera/camera
import entity/entity
import utils/print
import std/random
import raylib
import raylib_helpers/shapes
import controls/mouse

#[
  Game entry point, init, loop, and exit.
]#
proc initialize =
  
  randomize()

  for i in 0 .. rand(4 .. 10):
    Zombies.add(
      newZombie(
        (float) rand(-500 .. 500),
        (float) rand(-500 .. 500)
      )
    )
  
  setConfigFlags(flags(WindowResizable))
  initWindow(800, 600, "Hello")
  setTargetFPS(60)


proc mainLoop =
  # Update procedure.
  Mouse.update()


  let directionVector = SinglePlayer.getPosition() - Mouse.getWorldPosition()

  let yaw = radToDeg arctan2(directionVector.getY(), directionVector.getX())

  SinglePlayer.setYaw(yaw)



  # Draw procedure.
  beginDrawing()
  Cam.update()
  beginMode2D(Cam)
  clearBackground(Black)


  # drawText("hi", 0,0,32, RayWhite)

  var rectangle = newRectangle(SinglePlayer.getPosition(), 100, 150)

  # Render the player.
  drawRectangle(rectangle, rectangle.getCenter(), SinglePlayer.getYaw(), Red)

  # Render the zombies.
  for zombie in Zombies.getAll():
    rectangle.setPosition(zombie.getPosition())
    drawRectangle(rectangle, rectangle.getCenter(), radToDeg zombie.getYaw(), DarkGreen)

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