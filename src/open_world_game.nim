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

proc fill(basePosition: Vector2f, radius: float, color: Color) =
  let xMin = (int)floor(basePosition.getX() - radius)
  let xMax = (int)floor(basePosition.getX() + radius)
  let yMin = (int)floor(basePosition.getY() - radius)
  let yMax = (int)floor(basePosition.getY() + radius)
  for x in countUp(xMin, xMax):
    for y in countup(yMin, yMax):
      let currentPos = newVector2f((float)(x) + 0.5,(float)(y) + 0.5)
      if currentPos.distance(basePosition) < radius:
        drawPixel(currentPos, color)

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


  let headOutlineColor = Red
  let headFillColor = Yellow

  # drawRectangle(person, Red)

  

  let basePosition = headBasePosition + newVector2f(sin(-headRotation), cos(headRotation)) * headDistance

  let headRadius = 100.0

  let eyeRadius = 20.0

  let leftEyeBase = newVector2f(basePosition.getX() - 50, basePosition.getY() - 40)
  let rightEyeBase = newVector2f(basePosition.getX() + 50, basePosition.getY() - 40)

  let pupilRadius = 5.0
  let pupilDistance = eyeRadius - pupilRadius

  var pupilOffset = newVector2f(sin(-eyeRotation), cos(eyeRotation)) * pupilDistance

  var yaw = 0.0

  # Head fill.
  fill(basePosition, headRadius, headFillColor)

  while yaw < PI * 2.0:

    yaw += 0.001

    # Head lines.

    var headPosX = floor(sin(-yaw) * headRadius) + basePosition.getX()
    var headPosY = floor(cos(yaw) * headRadius) + basePosition.getY()
    var headPos = Vector2(x: headPosX, y: headPosY)

    drawPixel(headPos, headOutlineColor)


  let eyeFillColor = White
  let eyeOutlineColor = Black

  # Left eye fill.
  fill(leftEyeBase, eyeRadius, eyeFillColor)

  yaw = 0

  while yaw < PI * 2.0:

    yaw += 0.001

    # Left eye lines.

    var leftEyePosX = floor(sin(-yaw) * eyeRadius) + leftEyeBase.getX()
    var leftEyePosY = floor(cos(-yaw) * eyeRadius) + leftEyeBase.getY()
    var leftEyePos = Vector2(x: leftEyePosX, y: leftEyePosY)
    
    drawPixel(leftEyePos, eyeOutlineColor)

  # Right eye fill.
  fill(rightEyeBase, eyeRadius, eyeFillColor)

  yaw = 0

  while yaw < PI * 2.0:
    
    yaw += 0.001

    # Right eye lines.

    var rightEyePosX = floor(sin(-yaw) * eyeRadius) + rightEyeBase.getX()
    var rightEyePosY = floor(cos(-yaw) * eyeRadius) + rightEyeBase.getY()
    var rightEyePos = Vector2(x: rightEyePosX, y: rightEyePosY)
    
    drawPixel(rightEyePos, eyeOutlineColor)

  let pupilFillColor = Black
  let pupilOutlineColor = Green

  # Left pupil fill.
  fill(leftEyeBase + pupilOffset, pupilRadius, pupilFillColor)

  yaw = 0

  while yaw < PI * 2.0:
    
    yaw += 0.001

    # Left pupil lines.

    var leftPupilPosX = floor(sin(-yaw) * pupilRadius) + leftEyeBase.getX() + pupilOffset.getX()
    var leftPupilPosY = floor(cos(-yaw) * pupilRadius) + leftEyeBase.getY() + pupilOffset.getY()
    var leftPupilPos = Vector2(x: leftPupilPosX, y: leftPupilPosY)

    drawPixel(leftPupilPos, pupilOutlineColor)

  # Right pupil fill.
  fill(rightEyeBase - pupilOffset, pupilRadius, pupilFillColor)


  yaw = 0

  while yaw < PI * 2.0:
    
    yaw += 0.001

    # Right pupil
    var rightPupilPosX = floor(sin(-yaw) * pupilRadius) + rightEyeBase.getX() - pupilOffset.getX()
    var rightPupilPosY = floor(cos(-yaw) * pupilRadius) + rightEyeBase.getY() - pupilOffset.getY()
    var rightPupilPos = Vector2(x: rightPupilPosX, y: rightPupilPosY)

    drawPixel(rightPupilPos, pupilOutlineColor)

  # Begin drawing mouth.
  
  let mouthWidth = 140.0
  var mouthUpperBasePos = newVector2f(
    basePosition.getX() - (mouthWidth / 2.0),
    basePosition.getY() + 20
    )
  let mouthHeight = 30.0

  let mouthColor = Black

  # Fill mouth. ( ͡° ͜ʖ ͡°)
  block:
    # This is such a specific procedure I don't feel like giving it a proc.

    for x in countUp((int)mouthUpperBasePos.getX(),(int)(mouthUpperBasePos.getX() + mouthWidth)):
      let currentMouthDepth = mouthUpperBasePos.getY() + (sin(PI * ((float)(x - (int)mouthUpperBasePos.getX()) / mouthWidth)) * ((cos(eyeRotation) + 1.0) * mouthHeight))
      for y in countUp((int)mouthUpperBasePos.getY(), (int)(currentMouthDepth)):
        let currentPosition = newVector2f((float)x,(float)y)
        drawPixel(currentPosition, DarkGray)

    # Now give it a tounge
    yaw = 0

    let tongueRadius = 30.0

    let tonguePosition = mouthUpperBasePos + newVector2f(mouthWidth / 2.0, 40)
    
    # while yaw <= PI * 2.0:
    block:
      let xMin = (int)floor(tonguePosition.getX() - tongueRadius)
      let xMax = (int)floor(tonguePosition.getX() + tongueRadius)
      let yMin = (int)floor(tonguePosition.getY() - tongueRadius)
      let yMax = (int)floor(tonguePosition.getY() + tongueRadius)
      for x in countUp(xMin, xMax):
        let currentMouthDepth = mouthUpperBasePos.getY() + (sin(PI * ((float)(x - (int)mouthUpperBasePos.getX()) / mouthWidth)) * ((cos(eyeRotation) + 1.0) * mouthHeight))
        for y in countup(yMin, (int)currentMouthDepth):
          let currentPos = newVector2f((float)(x) + 0.5,(float)(y) + 0.5)
          if currentPos.distance(tonguePosition) < tongueRadius:
            drawPixel(currentPos, Red)



  yaw = 0

  while yaw <= 1:

    # Upper portion.
    var upperPos = newVector2f(
      mouthUpperBasePos.getX() + (yaw * mouthWidth),
      mouthUpperBasePos.getY()
    )

    drawPixel(upperPos, mouthColor)

    # Lower portion.
    var lowerPos = newVector2f(
      mouthUpperBasePos.getX() + (yaw * mouthWidth),
      mouthUpperBasePos.getY() + (sin(PI * yaw) * ((cos(eyeRotation) + 1.0) * mouthHeight))
    )

    drawPixel(lowerPos, mouthColor)


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