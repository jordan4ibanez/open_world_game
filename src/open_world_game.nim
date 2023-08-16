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
import intro/intro
import sound/sound

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
  setTargetFPS(144)
  initAudioDevice()
  initFont("font/roboto.ttf")
  maximizeWindow()

var shadowRotation = 0.0

proc mainLoop =
  # Update procedure.
  
  Mouse.update()

  controlPlayer()

  shadowRotation += 0.1
  if shadowRotation > PI * 2:
    shadowRotation -= PI * 2



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

  # Render the zombie's UUID.
  Text.setSize(30)
  Text.setColor(Green)
  Text.setShadowColor(Blue)
  Text.setShadowOffset((shadowRotation * -1.0).direction 2)

  for zombie in Zombies.getAll():
    # echo zombie.getID
    textDrawCentered(zombie.getID, zombie.getPosition + newVector2f(0,-100))

  drawCircle(Mouse.getWorldPosition(), 4, White)

  endMode2D()

  performBootSequence()
  
  Text.setSize(50)
  Text.setColor(Red)
  Text.setShadowColor(White)
  Text.setShadowOffset(shadowRotation.direction 4)

  textDraw(SinglePlayer.getPosition().toString("position"), 100, 100)
  textDraw(Mouse.getWorldPosition().toString("mouse"), 100, 150)
  textDraw("FPS: " & $getFPS(), 100, 200)
  

  endDrawing()


proc cleanUp =

  cleanUpSounds()
  closeAudioDevice()
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
