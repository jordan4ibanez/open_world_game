import ../noml/vector2i
import std/tables
import uuids

#[
  Holds the blueprints for entities.
]#
type

  Entity = ref object of RootObj
    position: Vector2i
  
  Item = ref object of Entity
    name: string
  
  LivingEntity = ref object of Entity
    health: int

  Player* = ref object of LivingEntity

  Zombie* = ref object of LivingEntity


var items = initTable[string, Item]()

proc addItem*(name: string, position: Vector2i) =
  let id: string = $genUUID()
  items[id] = Item(name: name, position: position)

proc addItem*(name: string, x,y: int) =
  addItem(name, newVector2i(x, y))

