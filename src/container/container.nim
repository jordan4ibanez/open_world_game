import std/sugar
import std/tables

#[
  Generic container implementation so I don't accidentally break things.
  Which has happened plenty times before.
  This is a wrapper around a table.
]#
type
  Container[T] = ref object of RootObj
    values: Table[string, T]

proc add*[T](container: Container, key: string, obj: T) =
  container.values[key] = obj

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

proc getAll*[T](container: Container[T]): seq[T] =
  # Table[system.string, T]
  return collect:
    for item in container.values.values:
      item
