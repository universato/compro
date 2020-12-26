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
      break if @heap[par] <= x

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
      child_1 = i * 2 + 2
      child = child_1 if child_1 < @size && @heap[child_1] < @heap[child]
      break if @heap[child] >= x

      @heap[i] = @heap[child]
      i = child
    end

    @heap[i] = x
    @heap.delete_at(-1)
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

  def all
    @heap
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
  dist = Array.new(g.size, inf)
  dist[s] = 0

  que = PriorityQueue.new
  que.push([0, s])

  while que.any?

    d, v = que.pop
    next if dist[v] < d

    # p g[v]
    g[v].each do |e|
      if dist[e.to] > dist[v] + e.cost
        dist[e.to] = dist[v] + e.cost
        que.push([dist[e.to], e.to ])
      end
    end
    # p que
  end

  # dist
  dist.map!{ |d| d == inf ? "INF" : d }
end

v, e, r = gets.to_s.split.map(&:to_i)

G = Array.new(v){ [] }
e.times do
  s, t, d = gets.to_s.split.map(&:to_i)
  G[s] << Node.new(t, d)
  # G[t] << Node.new(s, d)
end
# pp G

puts dijkstra(G, r)

# judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A
# http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_A
# http://judge.u-aizu.ac.jp/onlinejudge/review.jsp?rid=4445328
