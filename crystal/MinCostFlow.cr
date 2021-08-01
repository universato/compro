require "./priority_queue.cr"

# Min Cost Flow Grapsh
class MinCostFlow
  class Edge
    getter to : Int32
    property rev : Int32
    property cap : Int64
    property cost : Int64
    def initialize(@to, @rev, @cap, @cost)
    end
    def inspect(io)
      io << "{to: #{@to}, rev: #{@rev}, cap: #{@cap}, cost: #{@cost}}"
    end
  end

  getter n : Int32
  getter g : Array(Array(Edge))
  getter pos : Array(Tuple(Int32, Int32))
  def initialize(@n)
    @n    = n
    @pos  = [] of Tuple(Int32, Int32)
    @g = Array(Array(Edge)).new(@n){ [] of Edge }
    @pv   = Array(Int32).new(n, 0)
    @pe   = Array(Int32).new(n, 0)
    @dual = Array(Int64).new(n, 0)
  end

  def add_edge(from, to, cap, cost) : Int32
    edge_number = @pos.size

    @pos << {from, @g[from].size}

    from_id = @g[from].size
    to_id   = @g[to].size
    to_id += 1 if from == to
    @g[from] << Edge.new(to, to_id, cap.to_i64, cost)
    @g[to]   << Edge.new(from, from_id, 0i64, -cost)

    edge_number
  end

  def get_edge(i)
    _e = @g[@pos[i][0]][@pos[i][1]]
    _re = @g[_e.to][_e.rev]
    [@pos[i][0], _e.to, _e.cap + _re.cap, _re.cap, _e.cost]
  end

  def edges
    @pos.map do |(from, id)|
      _e  = @g[from][id]
      _re = @g[_e.to][_e.rev]
      [from, _e.to, _e.cap + _re.cap, _re.cap, _e.cost]
    end
  end

  def flow(s, t, flow_limit = Int64::MAX)
    slope(s, t, flow_limit).last
  end

  def dual_ref(s, t)
    dist = Array.new(@n, Int64::MAX)
    @pv.fill(-1)
    @pe.fill(-1)
    vis = Array(Bool).new(@n, false)

    que = PriorityQueue(Tuple(Int64, Int32)).new
    dist[s] = 0
    que.push({0i64, s})

    while dv = que.pop?
      d, v = dv
      next if vis[v]

      vis[v] = true
      break if v == t

      @g[v].size.times do |i|
        e = @g[v][i]
        next if vis[e.to] || e.cap == 0

        cost = e.cost - @dual[e.to] + @dual[v]
        next unless dist[e.to] - dist[v] > cost

        dist[e.to] = dist[v] + cost
        @pv[e.to] = v
        @pe[e.to] = i
        que.push({dist[e.to], e.to})
      end
    end

    return false unless vis[t]

    @n.times do |i|
      next unless vis[i]

      @dual[i] -= dist[t] - dist[i]
    end

    true
  end

  def slope(s, t, flow_limit = Int64::MAX)
    flow = 0
    cost = 0
    prev_cost = -1
    result = [[flow, cost]]

    while flow < flow_limit
      break unless dual_ref(s, t)

      c = flow_limit - flow
      v = t
      while v != s
        c = @g[@pv[v]][@pe[v]].cap if c > @g[@pv[v]][@pe[v]].cap
        v = @pv[v]
      end

      v = t
      while v != s
        e = @g[@pv[v]][@pe[v]]
        e.cap -= c
        @g[v][e.rev].cap += c
        v = @pv[v]
      end

      d = -@dual[s]
      flow += c
      cost += c * d
      result.pop if prev_cost == d
      result << [flow, cost]
      prev_cost = d
    end

    result
  end
end

def test_dayo
  # r, g, b = gets.to_s.split.map{ |e| e.to_i }
  r, g, b = [2i64, 3i64, 4i64]
  v = 1006
  graph = MinCostFlow.new(v)
  graph.add_edge(0, 3, b.to_i64, 0i64)
end

# test_dayo

def abc004
  r, g, b = gets.to_s.split.map{ |e| e.to_i }
  # r, g, b = [2i64, 3i64, 4i64]
  # r, g, b = [17i64, 2i64, 34i64]
  v = 1006
  graph = MinCostFlow.new(v)
  graph.add_edge(0, 1, r, 0i64);
  graph.add_edge(0, 2, g, 0i64);
  graph.add_edge(0, 3, b, 0i64);

  (-500 .. 500).each do |i|
    graph.add_edge(1, i + 504, 1, (i + 100).abs.to_i64) # red(-100)
    graph.add_edge(2, i + 504, 1, i.abs.to_i64)         # green(0)
    graph.add_edge(3, i + 504, 1, (i - 100).abs.to_i64) # blue(100)
    graph.add_edge(i + 504, 1005, 1, 0i64)
  end

  puts graph.flow(0, 1005, r + g + b)[-1]
end

# abc004
