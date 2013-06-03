from functools import partial
from types import FunctionType, LambdaType, TupleType

flip = lambda f: lambda *a: f(*reversed(a))

class _():
    def _isfun(self, obj):
        return type(obj) is FunctionType or type(obj) is LambdaType

    def __init__(self, *obj):
        if len(obj) == 0:
            self.func = lambda x:x
        else:
            if len(obj) > 1:
                if not self._isfun(obj[0]):
                    raise "tuple (func, arg1, .. ) must be applied"
                    
                self.func = partial(obj[0], *obj[1:])
            else:
                if self._isfun(obj[0]):
                    self.func = lambda x:obj[0](x)
                else:
                    self.func = lambda x:obj[0]
    
    def __lshift__(self, tpl):
        if type(tpl) is TupleType:
            if not self._isfun(tpl[0]):
                raise "tuple (func, arg1, .. ) must be applied"

            f = partial(tpl[0], *tpl[1:])
            f1 = self.func
            self.func = lambda x:f1(f(x))
            return self
        else:
            if self._isfun(tpl):
                f1 = self.func
                self.func = lambda x:f1(tpl(x))
                return self
            else:
                return self.func(tpl)

    def __call__(self, *tpl, **args):
        return self.func(*tpl, **args)
