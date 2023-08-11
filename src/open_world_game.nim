import noml/vector2i
import entity/entity


Items.add("bread", 0, 0)

for item in Items.getInRadius(newVector2i(0,0), 5):
  let id = item.getID

for item in Items.getAll:
  echo item[]