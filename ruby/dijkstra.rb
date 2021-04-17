# graph_list.rbに新しくdikstraを作った。

class PriorityQueue
  def initialize(heap = [])
    @size = heap.size
    @heap = heap.sort
  end
  attr_accessor :heap
  alias all heap

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
    @heap.pop
    ret
  end

  def size
    @heap.size
  end

  def top
    @heap[0]
  end

  def any?
    @size > 0
  end

  def empty?
    @size == 0
  end

  def first
    @heap[0]
  end

  def second
    @size < 3 ? @heap[1] : [@heap[1], @heap[2]].min
  end

  def third
    @size < 3 ? nil : [@heap[1], @heap[2]].max
  end
end

class Array
  include Comparable

  def to_pq
    PriorityQueue.new(self)
  end
end

class Node
  attr_accessor :to, :cost

  def initialize(to, cost)
    @to = to
    @cost = cost
  end
end

# with PriorityQueue O(|E|log|V|)
def dijkstra(g, s)
  # inf = 10 ** 12
  inf = Float::INFINITY
  dists = Array.new(g.size, inf)
  dists[s] = 0

  que = PriorityQueue.new
  que.push([0, s])

  while (d, v = que.pop)
    next if dists[v] < d

    g[v].each do |e|
      if dists[e.to] > dists[v] + e.cost
        dists[e.to] = dists[v] + e.cost
        que.push([dists[e.to], e.to])
      end
    end
  end

  dists.map!{ |d| d == inf ? "INF" : d }
end

def test_agl1a
  v, e, r = gets.to_s.split.map(&:to_i)

  g = Array.new(v){ [] }
  e.times do
    s, t, d = gets.to_s.split.map(&:to_i)
    g[s] << Node.new(t, d)
    # g[t] << Node.new(s, d)
  end

  puts dijkstra(g, r)
end

# judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A
# http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A
# http://judge.u-aizu.ac.jp/onlinejudge/review.jsp?rid=4445328


# 作りかけ
# graph_list.rbを見た方がよさそう。
def test_yosupo
  v, e, r = gets.to_s.split.map(&:to_i)

  g = Array.new(v){ [] }
  e.times do
    s, t, d = gets.to_s.split.map(&:to_i)
    g[s] << Node.new(t, d)
    # g[t] << Node.new(s, d)
  end

  puts dijkstra(g, r)
end
