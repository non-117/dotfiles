from pipe import *
split = Pipe(lambda s, sep: s.split(sep))
strip = Pipe(str.strip)
toUTF = Pipe(lambda s:s.decode("UTF-8"))
fromUTF = Pipe(lambda s:s.encode("UTF-8"))
