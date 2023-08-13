import raylib
import std/enumutils
import std/tables
import std/strutils

var stringKey = newTable[string, KeyboardKey]()

for key in KeyboardKey.items:
  stringKey[($key).toLower] = key

type KeyboardObj = object of RootObj

proc keyPressed*(keyboard: KeyboardObj, keyName: string): bool =
  isKeyPressed(stringKey[keyName.toLower])

proc keyDown*(keyboard: KeyboardObj, keyName: string): bool =
  isKeyDown(stringKey[keyName.toLower])

proc keyReleased*(keyboard: KeyboardObj, keyName: string): bool =
  isKeyReleased(stringKey[keyName.toLower])

proc keyUp*(keyboard: KeyboardObj, keyName: string): bool =
  isKeyUp(stringKey[keyName.toLower])

proc listKeys*(keyboard: KeyboardObj) =
  for key in KeyboardKey.items:
    stringKey[($key).toLower] = key

let Keyboard* = KeyboardObj()