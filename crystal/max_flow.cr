class MaxFlow
  class Edge
    #getter from : Int64
    #getter to : Int64
    #property cap : Int64
    #property flow : Int64
    #def initialize(@from, @to, @cap, @flow)
    #end
  end

  class Edge2
    getter to : Int32
    property rev : Int32
    property cap : Int64
    def initialize(@to, @rev, @cap)
    end
    def inspect(io)
      io << "{to: #{@to}, rev: #{@rev}, cap: #{@cap}}"
    end
  end

  getter n : Int32
  getter g : Array(Array(Edge2))
  getter pos : Array(Tuple(Int32, Int32))
  def initialize(@n)
    @g = Array.new(@n){ [] of Edge2 }
    @pos = [] of Tuple(Int32, Int32)
  end

  def add_edge(from : Int, to : Int, cap : Int)
    m = @pos.size
    @pos.push({from, @g[from].size})
    from_id = @g[from].size
    to_id   = @g[to].size
    to_id += 1 if from == to
    @g[from].push(Edge2.new(to, to_id, cap))
    @g[to].push(Edge2.new(from, from_id, 0i64))
    m
  end

  def edges
    @pos.map do |(from, id)|
      _e  = @g[from][id]
      _re = @g[_e.to][_e.rev]
      [from, _e.to, _e.cap + _re.cap, _re.cap]
    end
  end

  def get_edge(i)
    _e  = @g[@pos[i][0]][@pos[i][1]]
    _re = @g[_e.to][_e.rev]
    [@pos[i][0], _e.to, _e.cap + _re.cap, _re.cap]
  end

  def change_edge(i, new_cap, new_flow)
    _e  = @g[@pos[i][0]][@pos[i][1]]
    _re = @g[_e.to][_e.rev]
    _e.cap  = new_cap - new_flow
    _re.cap = new_flow
  end

  def min_cut(s)
    visited = Deque.new(@n, false)
    que = [s]
    while (q = que.shift?)
      visited[q] = true
      @g[q].each do |e|
        if e.cap > 0 && !visited[e.to]
          visited[e.to] = true
          que << e.to
        end
      end
    end
    visited
  end

  def flow(s : Int, t : Int, flow_limit = Int64::MAX)
    level = [-1] * @n # Array(Int64).new(@n, -1)
    iter = Array(Int64).new(@n, 0)

    flow = 0_i64
    while flow < flow_limit
      bfs(s, t, level)
      break if level[t] == -1

      iter.fill(0i64)
      f = dfs(t, s, flow_limit - flow, level, iter)
      break if f <= 0
      flow += f
    end
    flow
  end

  # for ALPC
  def calc(s, ans, m)
    @g[s].each do |e|
      next if e.cap > 0

      i, j = e.to.divmod(m)
      @g[e.to].each do |f|
        next if f.cap > 0

        x, y = f.to.divmod(m)

        if i == x
          j, y = y, j if y < j
          ans[i][j], ans[i][y] = '>', '<'
        else
          i, x = x, i if x < i
          ans[i][j], ans[x][j] = 'v', '^'
        end
        break
      end
    end
  end

  private def bfs(s, t, level)
    level.fill(-1_i64)
    level[s] = 0_i64
    que = Deque(Int32).new
    que.push(s)
    while v = que.pop?
      g[v].each do |e|
        next if e.cap == 0 || level[e.to] >= 0

        level[e.to] = level[v] + 1
        return if e.to == v
        que.push(e.to)
      end
    end
  end

  # ac-library auto dfs = [&](auto self, int v, Cap up) {
  #                 f = dfs(dfs, t, flow_limit - flow);
  # ac-library-rb dfs(v, up, s, level, iter)
  # ac-library.cr private def dfs(node, target, flow))
  #               flowed = dfs(start, target, Int64::MAX)
  # 蟻本 dfs(v, t, f) dfs(s, t, INF)
  private def dfs(v, t, up, level, iter)
    return up if v == t

    res = 0
    level_v = level[v]
    while iter[v] < @g[v].size
      i = iter[v]
      e = @g[v][i]
      cap = @g[e.to][e.rev].cap
      if level_v > level[e.to] && cap > 0
        d = dfs(e.to, t, {up - res, cap}.min, level, iter)
        if d > 0
          @g[v][i].cap += d
          @g[e.to][e.rev].cap -= d
          res += d
          return res if res == up
        end
      end
      iter[v] += 1
    end
    level[v] = @n
    res
  end
end
