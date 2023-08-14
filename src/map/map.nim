import std/sequtils
import std/sugar

const mapSize = 256

type
  MapObj = ref object of RootObj
    tileData: array[mapSize, array[mapSize, int]]

proc init(map: MapObj): MapObj =
  for xArray in map.tileData.mitems:
    for yItem in xArray.mitems:
      yItem = 1
  map

var Map* = MapObj().init()