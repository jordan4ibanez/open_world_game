import ../noml/vector2f
import ../raylib_helpers/shapes
import std/sugar
import std/tables
import std/typetraits
import uuids
import std/random
import std/math

#[
  Holds the blueprints for entities.
]#
type

  Entity* = ref object of RootObj
    id: string
    position: Vector2f
  
  Item* = ref object of Entity
    name: string
  
  LivingEntity* = ref object of Entity
    health: int
    yaw: float = 0

  Player* = ref object of LivingEntity

  Zombie* = ref object of LivingEntity

#[
  Basic entity methods.
]#
proc getX*(entity: Entity): float =
  return entity.position.getX()

proc getY*(entity: Entity): float =
  return entity.position.getY()

proc getPosition*(entity: Entity): Vector2f =
  return entity.position

proc getID*(entity: Entity): string =
  return entity.id

proc getName*(item: Item): string =
  return item.name

proc getHealth*(livingEntity: LivingEntity): int =
  return livingEntity.health

proc setHealth*(livingEntity: LivingEntity, newHealth: int) =
  livingEntity.health = newHealth

proc getYaw*(livingEntity: LivingEntity): float =
  livingEntity.yaw

proc setYaw*(livingEntity: LivingEntity, yaw: float) =
  livingEntity.yaw = yaw

#[
  Entity constructors.
]#
proc newZombie*(position: Vector2f): Zombie =
  result = Zombie(position: position)
  result.setYaw(rand(0.0 .. 1.0) * PI)
  return result

proc newZombie*(x,y: float): Zombie =
  newZombie(newVector2f(x,y))

proc newItem*(position: Vector2f, name: string): Item =
  Item(position: position, name: name)

proc newItem*(x,y: float, name: string): Item =
  Item(position: newVector2f(x,y), name: name)


#[
  Generic container implementation so I don't accidentally break things.
  Which has happened plenty times before.
  This is a wrapper around a table.
]#
type
  Container[T] = ref object of RootObj
    values: Table[string, T]

proc add*[T](container: Container, obj: T): string {.discardable.} =
  let id: string = $genUUID()
  container.values[id] = obj
  return id

proc has*(container: Container, id: string): bool =
  return container.values.hasKey id

proc get*[T](container: Container, id: string): T =
  if not has id:
    raise newException(KeyError, "Could not find " & id)
  return container.values[id]

proc remove*(container: Container, id: string) =
  if not container.has id:
    raise newException(KeyError, "could not find" & id)
  container.values.del id

proc getInRadius*[T](container: Container, position: Vector2f, radius: float): seq[T] =
  for item in container.values.values:
    if position.distance(item.getPosition) <= radius:
      result.add item

proc getAll*[T](container: Container[T]): seq[T] =
  # Table[system.string, T]
  return collect:
    for item in container.values.values:
      item

#[
  Entity containers.
]#
var Items* = Container[Item]()
var Zombies* = Container[Zombie]()

#[
  The only player in the game.
]#
var SinglePlayer* = Player()
SinglePlayer.setHealth(10)