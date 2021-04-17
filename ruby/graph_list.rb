class PriorityQueue
  def initialize(heap = [])
    @size = heap.size
    @heap = heap.sort
  end

  # log( log n )
  def push(x)
    i = @size
    @size += 1
    while i > 0
      par = (i - 1) / 2
      break if @heap[par][0] <= x[0]

      @heap[i] = @heap[par]
      i = par
    end
    @heap[i] = x
  end

  # log( log n )
  # return nil if @size == 0
  def pop
    ret = @heap[0]
    x = @heap[@size -= 1]

    i = 0
    while (child = i * 2 + 1) < @size
      child1 = i * 2 + 2
      child = child1 if child1 < @size && @heap[child1][0] < @heap[child][0]
      break if @heap[child][0] >= x[0]

      @heap[i] = @heap[child]
      i = child
    end

    @heap[i] = x
    @heap.delete_at(-1)
    ret
  end
end

class Array
  include Comparable
end

# Graph List for Djikstra
class GraphList
  # Edge Node
  class EdgeNode
    def initialize(to, cost)
      @to = to
      @cost = cost
    end
    attr_accessor :to, :cost
  end

  def initialize(n)
    @g = Array.new(n){ [] }
  end

  def get_edge
    s, t, c = gets.to_s.split.map{ |e| e.to_i }
    @g[s] << EdgeNode.new(t, c)
    @g[t] << EdgeNode.new(s, c)
  end

  def get_edges(n = nil)
    if n
      n.times do
        s, t, c = gets.to_s.split.map{ |e| e.to_i }
        @g[s] << EdgeNode.new(t, c)
        @g[t] << EdgeNode.new(s, c)
      end
    else
      gest.to_s.split.map{ |e| e.to_i }.each_slice(3) do |s, t, c|
        @g[s] << EdgeNode.new(t, c)
        @g[t] << EdgeNode.new(s, c)
      end
    end
  end

  def add_edge(s, t, c = 1)
    @g[s] << EdgeNode.new(t, c)
    @g[t] << EdgeNode.new(s, c)
  end

  def add_edges(edges)
    edges.each do |s, t, c|
      @g[s] << EdgeNode.new(t, c)
      @g[t] << EdgeNode.new(s, c)
    end
  end

  def add_undirected_edge(s, t, c = 1)
    @g[s] << EdgeNode.new(t, c)
    @g[t] << EdgeNode.new(t, c)
  end

  def add_directed_edge(s, t, c = 1)
    @g[s] << EdgeNode.new(t, c)
  end

  def dijkstra(start, inf = Float::INFINITY, inf_str = "INF")
    dist = Array.new(@g.size, inf)
    dist[start] = 0
    @prev = Array.new(@g.size)

    que = PriorityQueue.new
    que.push([0, start])

    while (d, v = que.pop)
      next if dist[v] < d

      @g[v].each do |e|
        if dist[e.to] > dist[v] + e.cost
          dist[e.to] = dist[v] + e.cost
          @prev[e.to] = v
          que.push([dist[e.to], e.to])
        end
      end
    end

    dist.map!{ |d| d == inf ? inf_str : d }
  end

  def path(dst)
    cur = dst
    res = []
    while cur
      res.prepend(cur)
      cur = @prev[cur]
    end
    res
  end
end

# Directed Graph List
class DirectedGraphList < GraphList
  def get_edge
    s, t, c = gets.to_s.split.map{ |e| e.to_i }
    @g[s] << EdgeNode.new(t, c)
  end

  def get_edges(n = nil)
    if n
      n.times do
        s, t, c = gets.to_s.split.map{ |e| e.to_i }
        @g[s] << EdgeNode.new(t, c)
      end
    else
      gest.to_s.split.map{ |e| e.to_i }.each_slice(3) do |s, t, c|
        @g[s] << EdgeNode.new(t, c)
      end
    end
  end

  def add_edge(s, t, c = 1)
    @g[s] << EdgeNode.new(t, c)
  end

  def add_edges(edges)
    edges.each{ |s, t, c| @g[s] << EdgeNode.new(t, c) }
  end
end
DiGraphList = DirectedGraphList

# judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A
# http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A
# http://judge.u-aizu.ac.jp/onlinejudge/review.jsp?rid=4445328
def aoj_agl1a
  v, m, r = gets.to_s.split.map(&:to_i)
  edges = Array.new(m){ gets.to_s.split.map{ |e| e.to_i } }

  g = GraphList.new(v)
  g.add_edges(edges)

  puts g.dijkstra(r)
end

def yosupo
  n, m, s, t = gets.to_s.split.map(&:to_i)
  edges = Array.new(m){ gets.to_s.split.map{ |e| e.to_i } }

  g = DiGraphList.new(n)
  g.add_edges(edges)

  d = g.dijkstra(s)
  if d[t] == "INF"
    puts -1
  else
    path = g.path(t)
    printf("%d %d\n", d[t], path.size - 1)
    puts path.each_cons(2).map{ |t| t.join(' ') }
  end
end
