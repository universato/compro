require './union_find'

p uf = UnionFind.new(5)
p uf.unite(3, 4)
p uf.same?(3, 4)
