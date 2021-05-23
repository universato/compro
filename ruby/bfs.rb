# mod = 10**9 + 7

# n = gets.to_s.to_i

# g = Array.new(n){ [] }
# (n - 1).times do
#   s, t, w = gets.to_s.split.map{ |t| t.to_i }
#   s -= 1
#   t -= 1
#   g[s] << [t, w]
#   g[t] << [s, w]
# end

# g[v]が、2要素の配列のものは、頂点と距離のもの。
# g[v]が、1要素の整数値なのは、頂点番号のみ。距離は1、もしくはnil.
# g[v].each do |u|
# g[v].each do |(u, c)|

# 二重ループの中のd[v]は外で置いた方がいい。
# d[u] = d[v] + 1

# Input: 小さい頂点から親を順番に与えられるタイプ。
# 「頂点0は根として親がない」or「」
# ex1
# -1, 0, 1, 2, 1, 0
# 0 - 5
#   ∟ 1 - 2 - 3
#       ∟ 4
# pop:   DFS: 0, 5, 1, 4, 2, 3   # DFS だけど、BFSと見分けがつかないかも。
# shift: BFS: 0, 1, 5, 2, 4, 3   # BFS

# -1, 0, 1, 2, 1, 0, 5
# 0 - 5 - 6
#   ∟ 1 - 2 - 3
#       ∟ 4
# pop:   DFS: 0, 5, 6, 1, 4, 2, 3
# shift: BFS: 0, 1, 5, 2, 4, 6, 3

parents = [-1, 0, 1, 2, 1, 0, 5]
n = parents.size
children = Array.new(n){ [] }
g = Array.new(n){ [] }
parents.each_with_index{ |parent, child|
  next unless parent >= 0
  children[parent] << child if parent >= 0
  g[parent] << child
  g[child] << parent
}

p children
p g

# main
d = [-1] * n
s = 0
d[s] = 0
q = [s]
while ( v = q.shift )
  # p v # pop: 0, 5, 1, 4, 2, 3   # DFS だけど、BFSと見分けがつかないかも。
  p v # shift: 0, 1, 5, 2, 4, 3 # BFS
  g[v].each do |u|
    next if d[u] >= 0
    # p [v, u] # shift: [0, 1], [0, 5], [1, 2], [1, 4], [2, 3]
    # p [v, u] # pop:   [0, 1], [0, 5], [1, 2], [1, 4], [2, 3]
    d[u] = d[v] + 1
    q << u
  end
end

p d
