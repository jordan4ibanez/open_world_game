import raylib
import ../container/container
import ../utils/box

var sounds = Container[ref Sound]()

proc soundPlay*(fileName: string) =
  if not sounds.contains fileName:
    sounds.add(fileName, box loadSound("sounds/" & fileName))
  playSound(sounds.get(fileName)[])


# converter
