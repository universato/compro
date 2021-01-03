# Priority Queue
class PriorityQueue
  def initialize(heap = [])
    @heap = heap.sort
  end
  attr_accessor :heap
  alias all heap

  # log( log n )
  def push(x)
    i = @heap.size
    while i > 0
      par = (i - 1) / 2
      break if @heap[par] <= x

      @heap[i] = @heap[par]
      i = par
    end
    @heap[i] = x
    self
  end
  alias << push
  alias append push

  # log( log n )
  # return nil if @size == 0
  def pop
    ret = @heap[0]
    sz = @heap.size - 1
    x = @heap[sz]
    # @heap.delete_at(-1)

    i = 0
    while (child1 = i * 2 + 1) < sz
      child2 = i * 2 + 2
      child1 = child2 if child2 < sz && @heap[child2] < @heap[child1]
      break if @heap[child1] >= x

      @heap[i] = @heap[child1]
      i = child1
    end

    @heap[i] = x
    @heap.delete_at(-1)
    ret
  end

  def top
    @heap[0]
  end
  alias get top
  # alias min top

  require 'forwardable'
  extend Forwardable
  def_delegators(:@heap, :size, :empty?, :sum, :first)

  def any?
    !@heap.empty?
  end

  def second
    @heap.size < 3 ? @heap[1] : [@heap[1], @heap[2]].min
  end

  def third
    @heap.size < 3 ? nil : [@heap[1], @heap[2]].max
  end
end

class Array
  include Comparable

  def to_pq
    PriorityQueue.new(self)
  end
  alias to_priority_queue to_pq

  def -@
    map{ |e| -e.to_i }
  end
end

# r = Array.new(25){ |i| i }.shuffle
# pq = r.to_pq
# p pq
# a = []
# p a[5353434]
# p a.size
# a[0] = 1
# p a.size
# puts ""
# puts "aaa"
# puts [nil, 5].min

# t = 0 if (i= 99)
# p i

# orange = PriorityQueue.new
# p ["none pop", orange.pop]
# p ['a', 'b'].max

# puts ""

# n = 100
# pq = Array.new(n){|i| [i, 0] }.shuffle.to_pq
# pq.size
# pq.top
# n.times{ |i| pq.pop }
# p pq.all
# puts ""

# 蟻本 2-4 p.71
# AtCoder ABC137 D - Summer Vacation
# AtCoder PAST002 F - タスクの消化

# [ruby] Priority Queueの実装 | このコードわからん
# https://hai3.net/blog/ruby-priority-queue/

# Ruby で Priority Queue を実装してみたい - Qiita
# https://qiita.com/mochizukikotaro/items/c335e6dcc5020ead0b92
