# -*- coding: utf-8 -*-
import cPickle as pickle

def serialize(obj, filename):
    with open(filename, "wb") as f:
        pickle.dump(obj, f)

def deserialize(filename):
    with open(filename, "rb") as f:
        return pickle.load(f)
