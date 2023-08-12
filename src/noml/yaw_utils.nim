import std/math

const PI2 = PI * 2.0

proc wrapperYaw*(yaw: var float) =
  if yaw < -PI2:
    yaw += PI2
  elif yaw > PI:
    yaw -= PI2
