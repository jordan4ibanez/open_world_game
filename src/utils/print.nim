template print*(s: varargs[string, `$`]) =
  for x in s:
    stdout.write x

template println*(s: varargs[string, `$`]) =
  for x in s:
    stdout.write x
  stdout.write '\n'