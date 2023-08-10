import ../noml/vector2i

type
  Entity = ref object of RootObj
    position: Vector2i
  
  LivingEntity = ref object of Entity
    health: int = 20

  Player* = ref object of LivingEntity

  Zombie* = ref object of LivingEntity

