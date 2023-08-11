import ../noml/vector2i
import std/tables
import uuids

#[
  Holds the blueprints for entities.
]#
type

  Entity = ref object of RootObj
    id: string
    position: Vector2i
  
  Item = ref object of Entity
    name: string
  
  LivingEntity = ref object of Entity
    health: int

  Player* = ref object of LivingEntity

  Zombie* = ref object of LivingEntity

#[
  Basic entity things
]#
proc getPosition*(entity: Entity): Vector2i =
  return entity.position

proc getID*(entity: Entity): string =
  return entity.id

proc getName*(item: Item): string =
  return item.name

proc getHealth*(livingEntity: LivingEntity): int =
  return livingEntity.health

#[
  Generic container implementation so I don't accidentally break things.
  Which has happened plenty times before.
  This is a wrapper around a table.
]#
type
  Container[T] = ref object of RootObj
    values: Table[string, T]

proc add*(container: Container, name: string, position: Vector2i) =
  let id: string = $genUUID()
  container.values[id] = Item(name: name, position: position)

proc add*(container: Container, name: string, x,y: int) =
  add container, name, newVector2i(x, y)

proc has*(container: Container, id: string): bool =
  return container.values.hasKey id

proc get*(container: Container, id: string): Item =
  if not has id:
    raise newException(KeyError, "Could not find " & id)
  return container.values[id]

proc remove*(container: Container, id: string) =
  if not has id:
    raise newException(KeyError, "could not find" & id)
  container.values.del id

proc getInRadius*(container: Container, position: Vector2i, radius: float): seq[Item] =
  for item in container.values.values:
    if position.distance(item.getPosition) <= radius:
      result.add item

proc getAll*(container: Container): Table =
  return container.values.values

#[
  Entity containers.
]#
var Items* = Container[Item]()
var Zombies* = Container[Zombie]()

#[
  The only player in the game.
]#
var SinglePlayer* = Player()

