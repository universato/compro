# ABC004 D - マーブルで試したが、ac-library-rbの実装の方が速かった。
# ac-library-rbは1663ms. こっちは、1815 ~ TLE. (2020/1/4 Ruby 2.7)

# Edge
class Edge
  def initialize(to, cap, cost, rev)
    @to, @cap, @cost, @rev = to, cap, cost, rev
  end
  attr_accessor :to, :cap, :cost, :rev
end

# Min Cost Flow Graph
class MinCostFlow
  INF = 10**16

  def initialize(n)
    @g = Array.new(n){ [] }
    @dist_for_fill = [INF] * n
    @prevv = [] * n
    @preve = [] * n
    @n = n
  end
  attr_reader :g, :prevv, :preve, :n

  def add_edge(from, to, cap, cost)
    @g[from].push(Edge.new(to, cap, cost, @g[to].size))
    @g[to].push(Edge.new(from, 0, -cost, @g[from].size - 1))
  end

  def min_cost_flow(s, t, f)
    res = 0
    while 0 < f
      dist = @dist_for_fill.dup
      dist[s] = 0
      update = true
      while update
        update = false
        @n.times do |v|
          next if dist[v] == INF

          @g[v].size.times do |i|
            e = @g[v][i]
            # p [cap, dist[to], dist[v], cost]
            if e.cap > 0 && dist[e.to] > dist[v] + e.cost
              dist[e.to] = dist[v] + e.cost
              @prevv[e.to] = v
              @preve[e.to] = i
              update = true
            end
          end
        end
      end
      return -1 if dist[t] == INF

      d = f
      v = t
      while v != s
        d = [@g[@prevv[v]][@preve[v]].cap, d].min
        v = @prevv[v]
      end
      f -= d
      res += d * dist[t]
      v = t
      while v != s
        e = @g[@prevv[v]][@preve[v]]
        e.cap -= d
        @g[v][e.rev].cap += d
        v = @prevv[v]
      end
    end
    res
  end
  alias flow min_cost_flow
  alias min_cost_max_flow min_cost_flow
end

def abc004
  r, g, b = gets.to_s.split.map{ |e| e.to_i }
  v = 1006
  graph = MinCostFlow.new(v)
  graph.add_edge(0, 1, r, 0)
  graph.add_edge(0, 2, g, 0)
  graph.add_edge(0, 3, b, 0)

  (-500 .. 500).each do |i|
    graph.add_edge(1, i + 504, 1, (i + 100).abs) # red(-100)
    graph.add_edge(2, i + 504, 1, i.abs)         # green(0)
    graph.add_edge(3, i + 504, 1, (i - 100).abs) # blue(100)
    graph.add_edge(i + 504, 1005, 1, 0)
  end

  puts graph.min_cost_flow(0, 1005, r + g + b)
end
