class PriorityQueue(T)
  @size : Int64
  @heap : Array(T)
  getter :size

  def initialize
    @size = 0_i64
    @heap = [] of T
  end

  def initialize(heap : Enumerable(T))
    @size = heap.size.to_i64
    @heap = heap.to_a.sort
  end

  # log( log n )
  def push(x)

    i = @size
    @size += 1
    return @heap = [x] if i == 0

    @heap << @heap[0]
    while i > 0
      par = ( i - 1 ) // 2
      break if @heap[par] <= x
      @heap[i] = @heap[par]
      i = par
    end
    @heap[i] = x
  end

  def <<(x)
    push(x)
  end

  # log( log n )
  # return error if pop when @size == 0
  def pop

    ret = @heap[0]
    x = @heap[@size-=1]

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

  def pop?(x)
    return nil if @heap.size == 0
    pop(x)
  end

  def top
    @heap[0]
  end

  def min
    @heap[0]
  end

  def all
    @heap
  end

  def any?
    @size > 0
  end

  delegate :empty?, to: @heap
end

class Array
  def to_pq
    PriorityQueue.new(self)
  end
end

class Node
  @to : Int64
  @cost : Int64

  property :to, :cost
  def initialize(to, cost)
    @to = to
    @cost = cost
  end
end

# with PriorityQueue O(|E|log|V|)
def dijkstra(g, s)
  inf = 1_000_000_000_000
  dist = Array.new(g.size, inf)
  dist[s] = 0_i64

  que = PriorityQueue(Array(Int64)).new
  que.push( [0_i64, s] )

  while que.any?

    d, v = que.pop
    next if dist[v] < d
    # p g[v]
    g[v].each do |e|
      if dist[e.to] > dist[v] + e.cost
        dist[e.to] = dist[v] + e.cost
        que.push( [dist[e.to], e.to ] )
      end
    end
    # p que
  end

  dist
  #dist.map!{|d| d == inf ? "INF" : d }
end

def aoj_agl1a
  v, e, r = gets.to_s.split.map{|t|t.to_i64}

  g = Array.new(v){ [] of Node }
  e.times do
    s, t, d = gets.to_s.split.map{|t|t.to_i64}
    g[s] << Node.new(t, d.to_i64)
  end

  puts dijkstra(g, r)
end
