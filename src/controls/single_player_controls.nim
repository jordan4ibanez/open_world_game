import raylib
import ../noml/vector2f
import ../entity/entity
import mouse
import keyboard
import std/math

#[
  This is player controls done purely functionally. For now.
]#

proc controlPlayer* =

  let yaw = SinglePlayer.getPosition().yaw(Mouse.getWorldPosition())

  SinglePlayer.setYaw(yaw)

  var pos = SinglePlayer.getPosition()
  
  var v = newVector2f(0,0)

  if Keyboard.keyDown("d"):
    pos = pos + v.set(5,0)
  if Keyboard.keyDown("a"):
    pos = pos + v.set(-5,0)
  if Keyboard.keyDown("w"):
    pos = pos + v.set(0,-5)
  if Keyboard.keyDown("s"):
    pos = pos + v.set(0,5)

  
  SinglePlayer.setPosition(pos)


  