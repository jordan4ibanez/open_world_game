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


var eyeRotation = 0.0
var headRotation = 0.0
let headDistance = 100.0
let headBasePosition = newVector2f(300, 300)

proc mainLoop =
  # Update procedure.

  # var person = RectangleRef(x: 100, y: 100, width: 220, height: 220)
  eyeRotation += 0.1
  if eyeRotation >= PI * 2.0:
    eyeRotation = 0.0
  
  headRotation += 0.01
  if headRotation >= PI * 2.0:
    headRotation = 0.0


  # Draw procedure.
  beginDrawing()
  clearBackground(Black)
  drawText("hi", 0,0,32, RayWhite)

  # drawRectangle(person, Red)

  var yaw = 0.0

  let basePosition = headBasePosition + newVector2f(sin(-headRotation), cos(headRotation)) * headDistance

  let headRadius = 100.0

  let eyeRadius = 20.0

  let leftEyeBase = Vector2(x: basePosition.getX() - 50, y: basePosition.getY() - 40)
  let rightEyeBase = Vector2(x: basePosition.getX() + 50, y: basePosition.getY() - 40)

  let pupilRadius = 5.0
  let pupilDistance = eyeRadius - pupilRadius

  var pupilOffset = newVector2f(sin(-eyeRotation), cos(eyeRotation)) * pupilDistance

  while yaw < PI * 2.0:

    yaw += 0.001

    # Head

    var headPosX = floor(sin(-yaw) * headRadius) + basePosition.getX()
    var headPosY = floor(cos(yaw) * headRadius) + basePosition.getY()
    var headPos = Vector2(x: headPosX, y: headPosY)

    drawPixel(headPos, Red)

    # Left eye

    var leftEyePosX = floor(sin(-yaw) * eyeRadius) + leftEyeBase.x
    var leftEyePosY = floor(cos(-yaw) * eyeRadius) + leftEyeBase.y
    var leftEyePos = Vector2(x: leftEyePosX, y: leftEyePosY)
    
    drawPixel(leftEyePos, Red)

    # Right eye

    var rightEyePosX = floor(sin(-yaw) * eyeRadius) + rightEyeBase.x
    var rightEyePosY = floor(cos(-yaw) * eyeRadius) + rightEyeBase.y
    var rightEyePos = Vector2(x: rightEyePosX, y: rightEyePosY)
    
    drawPixel(rightEyePos, Red)

    # Left pupil
    var leftPupilPosX = floor(sin(-yaw) * pupilRadius) + leftEyeBase.x + pupilOffset.getX()
    var leftPupilPosY = floor(cos(-yaw) * pupilRadius) + leftEyeBase.y + pupilOffset.getY()
    var leftPupilPos = Vector2(x: leftPupilPosX, y: leftPupilPosY)

    drawPixel(leftPupilPos, Red)

    # Right pupil
    var rightPupilPosX = floor(sin(-yaw) * pupilRadius) + rightEyeBase.x - pupilOffset.getX()
    var rightPupilPosY = floor(cos(-yaw) * pupilRadius) + rightEyeBase.y - pupilOffset.getY()
    var rightPupilPos = Vector2(x: rightPupilPosX, y: rightPupilPosY)

    drawPixel(rightPupilPos, Red)

  # Begin drawing mouth.
  yaw = 0
  
  let mouthWidth = 140.0
  var mouthUpperBasePos = newVector2f(
    basePosition.getX() - (mouthWidth / 2.0),
    basePosition.getY() + 20
    )
  let mouthHeight = 30.0

  while yaw <= 1:

    # Upper portion.
    var upperPos = newVector2f(
      mouthUpperBasePos.getX() + (yaw * mouthWidth),
      mouthUpperBasePos.getY()
    )

    drawPixel(upperPos, Red)

    # Lower portion.
    var lowerPos = newVector2f(
      mouthUpperBasePos.getX() + (yaw * mouthWidth),
      mouthUpperBasePos.getY() + (sin(PI * yaw) * ((cos(eyeRotation) + 1.0) * mouthHeight))
    )

    drawPixel(lowerPos, Red)


    yaw += 0.001








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