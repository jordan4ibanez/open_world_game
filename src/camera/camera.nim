import raylib
import ../noml/vector2f
import ../entity/entity


var Cam* = Camera2D(
  target: newVector2f(0,0),
  offset: newVector2f(0,0),
  rotation: 0,
  zoom: 1
)

proc update*(cam: var Camera2D) =
  cam.target = SinglePlayer.getPosition()
  cam.offset = newVector2f((float)(getRenderWidth()) / 2.0,(float)(getRenderHeight()) / 2.0)
  
proc getPosition*(cam: Camera2D): Vector2f =
  return cam.target - cam.offset