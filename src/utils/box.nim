proc box*[T](x: sink T): ref T =
  new(result); result[] = x