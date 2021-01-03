require_relative "../union_find_undo.rb"

n = 10
uf = UnionFind.new(n)

uf.undo

# uf.merge(0, 1)
# uf.merge(0, 2)
# uf.merge(0, 3)

# p uf.groups

# uf.undo

# p uf.groups

# uf.snapshot

# uf.merge(0, 3)
# uf.merge(0, 4)
# uf.merge(0, 5)

# p uf.groups

# uf.rollback

# p uf.groups
