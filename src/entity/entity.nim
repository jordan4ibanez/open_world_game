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

proc getPosition*(entity: Entity): Vector2i =
  return entity.position

var items = initTable[string, Item]()

proc addItem*(name: string, position: Vector2i) =
  let id: string = $genUUID()
  items[id] = Item(name: name, position: position)

proc addItem*(name: string, x,y: int) =
  addItem name, newVector2i(x, y)

proc hasItem*(id: string): bool =
  return items.hasKey id

proc getItem*(id: string): Item =
  if not hasItem id:
    raise newException(KeyError, "Could not find item " & id)
  return items[id]

proc itemsInRadius*(position: Vector2i, radius: float): seq[Item] =
  for item in items.values:
    if position.distance(item.getPosition) <= radius:
      result.add item


