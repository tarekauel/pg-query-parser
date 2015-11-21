_ = require 'lodash'

EXIT = {}

walk = (obj, func) ->
  if _.isArray(obj)
    for o in obj
      return o if func(obj, o) is EXIT

    walk(o, func) for o in obj
  else if _.isObject(obj)
    for k, v of obj
      return obj if func(obj, k, v) is EXIT

    walk(v, func) for k, v of obj
  else
    return obj if func(obj) is EXIT

first = (obj, func) ->
  walk obj, (obj, key, value) ->
    return EXIT if func(obj, key, value)

all = (obj, func) ->
  results = []
  walk obj, (obj, key, value) ->
    results.push(obj) if func(obj, key, value)
  results

clean = (tree) ->
  walk tree, (obj, k, v) ->
    return if _.isArray(obj)
    if k is 'location'
      delete obj.location
  tree

module.exports =
  walk: walk
  first: first
  all: all
  clean: clean
