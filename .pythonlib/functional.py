from functools import partial, reduce
from itertools import takewhile, starmap
from operator import iconcat

flip = lambda f: lambda *a: f(*reversed(a))
concat = partial(reduce, iconcat)


def compose_two(g, f):
    """Function composition for two functions, e.g. compose_two(f, g)(x) == f(g(x))"""
    return lambda *args, **kwargs: g(f(*args, **kwargs))
 
def compose(*funcs):
    """Compose an arbitrary number of functions left-to-right passed as args"""
    return reduce(compose_two, funcs)
 
def transform_args(func, transformer):
    return lambda *args: func(*transformer(args))
 
composed_partials = transform_args(compose, partial(starmap, partial))
pipe = transform_args(composed_partials, reversed)
