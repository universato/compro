class PriorityQueue

  def initialize(heap=[])
    @size = heap.size
    @heap = heap.sort
  end

  # log( log n )
  def push x
    i = @size
    @size += 1
    while i > 0
      par = ( i - 1 ) / 2
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
    x = @heap[@size-=1]
    @heap.delete_at(-1)

    i = 0
    while (child = i * 2 + 1) < @size
      child_1 = i * 2 + 2
      child = child_1 if child_1 < @size && @heap[child_1] < @heap[child]
      break if @heap[child] >= x
      @heap[i] = @heap[child]
      i = child
    end

    @heap[i] = x
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

# r = Array.new(100){|i| i}.shuffle
# pq = r.to_pq
# # p pq
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

require 'minitest/autorun'

class MintExpendsNumeric_Test < Minitest::Test

  def test_pq
    pq = PriorityQueue.new
    pq.push(20)
    pq.push(1)
    pq.push(300)
    assert_equal 1, pq.pop
    assert_equal 20, pq.top
    assert_equal 2, pq.size
    assert pq.any?
  end

  def test_suhhle_array
    n = 100
    pq = Array.new(n){|i| i}.shuffle.to_pq
    assert_equal n, pq.size
    assert_equal 0, pq.top
    n.times{ |i| assert_equal i, pq.pop }
    assert pq.empty?
  end

  def test_suhhle_array2
    n = 100
    pq = Array.new(n){|i| [i, 0] }.shuffle.to_pq
    assert_equal n, pq.size
    assert_equal [0, 0], pq.top
    n.times{ |i| assert_equal [i, 0], pq.pop }
    assert pq.empty?
  end

  def test_alphabet_array
    rand_ary = ('a'..'z').to_a.shuffle
    n = rand_ary.size
    pq0 = rand_ary.to_pq
    pq1 = PriorityQueue.new
    rand_ary.each{ |e| pq1.push(e) }
    assert_equal pq0.size, pq1.size
    assert_equal pq0.top, pq1.top
    n.times{ |i| assert_equal pq0.pop, pq1.pop }
    assert pq0.empty?
    assert pq1.empty?
  end

  def test_muda_na_kakucho
    rand_ary = ('a'..'z').to_a.shuffle
    n = rand_ary.size
    pq = rand_ary.to_pq
    assert_equal 'a', pq.first
    assert_equal 'b', pq.second
    assert_equal 'c', pq.third

    pq1 = ('a'..'b').to_a.shuffle.to_pq
    assert_nil pq1.third
  end
end
