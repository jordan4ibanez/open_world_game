import std/strutils

var running: bool = true

proc parseInput(input: string): seq[string] =
  return input.split

proc interpretCommand(input: seq[string]) =
  case input[0].toLower:
  of "forward":
    # do things
    echo "hi"
  of "backward":
    # do things
    echo "hi"
  of "left":
    # do things
    echo "hi"
  of "right":
    # do things
    echo "hi"
  of "":
    echo "You must type something!"
  of "quit", "exit", "leave", "bye", "seeya":
    running = false
  else:
    #println
    echo("Don't know how to " & input)

while (running):
  #print
  echo "> "
  let input = parseInput readLine stdin
  interpretCommand input