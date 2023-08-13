import raylib
import ../noml/vector2f
import ../entity/entity
import mouse
import std/math

#[
  This is player controls done purely functionally. For now.
]#

proc controlPlayer* =

  let directionVector = SinglePlayer.getPosition() - Mouse.getWorldPosition()

  let yaw = radToDeg arctan2(directionVector.getY(), directionVector.getX())

  SinglePlayer.setYaw(yaw)