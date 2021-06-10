# [強連結成分分解 \(Kosaraju's Algorithm\) \- yaketake08's 実装メモ](https://tjkendev.github.io/procon-library/python/graph/scc.html)

def scc(n, g, rg)
  order = []
  used = [0]*n
  group = [None]*n
  def dfs(s):
      used[s] = 1
      for t in G[s]:
          if not used[t]:
              dfs(t)
      order.append(s)
  def rdfs(s, col):
      group[s] = col
      used[s] = 1
      for t in rg[s]:
          if not used[t]:
              rdfs(t, col)
  for i in range(n):
      if not used[i]:
          dfs(i)
  used = [0]*n
  label = 0
  for s in reversed(order):
      if not used[s]:
          rdfs(s, label)
          label += 1
  return label, group

# 縮約後のグラフを構築
def construct(n, G, label, group):
  G0 = [set() for i in range(label)]
  GP = [[] for i in range(label)]
  for v in range(n):
      lbs = group[v]
      for w in G[v]:
          lbt = group[w]
          if lbs == lbt:
              continue
          G0[lbs].add(lbt)
      GP[lbs].append(v)
  return G0, GP
