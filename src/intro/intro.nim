import raylib
import ../text/text

let bootSequence = @[
  "IMB 7094 LOADING...",
  "IMB 7094 ONLINE.",
  "POLARIS GUIDANCE SYSTEMS LOADING...",
  "POLARIS GUIDANCE SYSTEMS ONLINE.",
  "ACQUIRING TARGET INFRASTRUCTURE DATABASE...",
  "TARGET INFRASTRUCTURE DATABASE ONLINE",
  "PERFORMING SYSTEM TESTS...",
  "ALL SYSTEM TESTS PASSED.",
  "SYSTEM READY.",
  "ROOT>"
]

var complete = false
var line = 0
var lineLength = bootSequence[line].len
var letter = 0
var typingAccumulator = 0.0
var typingSpeed = 1.0
var typingGoal = 0.05
var linePause = 2.0
var linePauseAccumulator = 0.0

proc performBootSequence*: bool {.discardable.} =

  # todo: fade out here
  if complete: return true

  let delta = getFrameTime()
  textDraw(bootSequence[line][0..<letter], 0,(float)(line) * 32.0)

  if line > 0:
    for i in 0 ..< line:
      textDraw(bootSequence[i], 0,(float)(i) * 32.0)

  typingAccumulator += delta * typingSpeed

  if typingAccumulator >= typingGoal:
    if letter >= lineLength:
      linePauseAccumulator += delta
      if linePauseAccumulator >= linePause:
        inc line
        complete = line >= bootSequence.len
        if complete: return true
        lineLength = bootSequence[line].len
        linePauseAccumulator = 0.0
        typingAccumulator = 0.0
        letter = 0
      return false
    inc letter
    typingAccumulator = 0.0



  return false
