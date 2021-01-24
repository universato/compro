class Tree
  def self.get(n = nil)
      n ||= gets.to_s.to_i
      tree = Tree.new(n)
      (n - 1).times do
        s, t, w = gets.to_s.split.map{ |t| t.to_i }
        w = w.to_i64
        tree.g[s].push({t, w})
        tree.g[t].push({s, w})
      end
      tree
  end

  getter g : Array(Array(Tuple(Int32, Int64)))
  def initialize(n)
    @g = Array.new(n){ [] of Tuple(Int32, Int64) }
  end

  def diameter(s = 0)
    max_node, max_len = bfs(s)
    max_node, max_len = bfs(max_node)
    max_len
  end

  private def bfs(s = 0)
    n = @g.size
    d = Array(Int64).new(n + 1, -1_i64)
    d[s] = 0_i64

    que = Deque(Int32).new
    que.push(s)

    max_node = s
    max_len = 0_i64
    while (v = que.shift?)
      cost = d[v]
      @g[v].each do |(u, edge_cost)|
        next if d[u] >= 0

        d[u] = tmp_len = cost + edge_cost
        max_len, max_node = tmp_len, u if max_len < tmp_len
        que.push(u)
      end
    end
    {max_node, max_len}
  end
end

puts Tree.get.diameter

# d = Array(Int64).new(n + 1); d[0] = 1_i64とやるとバグる。初期値をちゃんと指定する。
# 最後の返り値を[Int32, Int64]にしてたせいで、Array(Int32 | Int64)となって、変数の型がspecificじゃなくなった。{Int64, Int32}というTuple形式にしたら、事なきを得た。
