import noml/vector2f

import std/math
import std/strutils
import camera/camera
import entity/entity
import utils/print
import std/random
import raylib
import raylib_helpers/shapes
import controls/[mouse,single_player_controls,keyboard]
import text/text

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
  initFont("font/roboto.ttf")
  maximizeWindow()


proc mainLoop =
  # Update procedure.
  
  Mouse.update()

  controlPlayer()
  


  # Draw procedure.
  beginDrawing()
  Cam.update()
  beginMode2D(Cam)
  clearBackground(Black)


  drawText("hi", 0,0,32, RayWhite)

  var rectangle = newRectangle(SinglePlayer.getPosition(), 100, 150)

  # Render the player.
  drawRectangle(rectangle, rectangle.getCenter(), SinglePlayer.getYaw(), Red)

  # Render the zombies.
  for zombie in Zombies.getAll():
    rectangle.setPosition(zombie.getPosition())
    zombie.setYaw(zombie.getPosition().yaw(Mouse.getWorldPosition()))
    drawRectangle(rectangle, rectangle.getCenter(), zombie.getYaw(), DarkGreen)

  drawCircle(Mouse.getWorldPosition(), 4, White)

  endMode2D()

  drawText(getFont(), SinglePlayer.getPosition().toString("position"), newVector2f(100,100), (float)32, 2, Lime)
  drawText(getFont(), Mouse.getWorldPosition().toString("mouse"), newVector2f(100,150), (float)32, 2, Lime)
  
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
