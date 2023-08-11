import noml/vector2f
import entity/entity
import std/strutils
import utils/print
import raylib

var running: bool = true

# proc parseInput(input: string): seq[string] =
#   return input.split

# proc interpretCommand(input: seq[string]) =
#   case input[0].toLower:
#   of "forward":
#     # do things
#     echo "hi"
#   of "backward":
#     # do things
#     echo "hi"
#   of "left":
#     # do things
#     echo "hi"
#   of "right":
#     # do things
#     echo "hi"
#   of "":
#     echo "You must type something!"
#   of "quit", "exit", "leave", "bye", "seeya":
#     running = false
#   else:
#     println("Don't know how to " & input)

# while (running):
  # print "> "
  # let input = parseInput readLine stdin
  # interpretCommand input

#[
  Game entry point, init, loop, and exit.
]#
proc initialize =
  initWindow(800, 600, "Hello")
  setTargetFPS(60)

proc mainLoop =
  # Update procedure.

  # Draw procedure.
  beginDrawing()
  clearBackground(Black)
  drawText("hi", 0,0,32, RayWhite)
  endDrawing()

proc cleanUp =
  closeWindow()



#[
  The above functional processes implemented in a nim-friendly manor.
]#
proc main =
  initialize()
  while not windowShouldClose():
    mainLoop()
  cleanUp()

main()