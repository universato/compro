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

# pq = PriorityQueue(Int32).new
# pq.push(5)
# pq.push(10)
# pq.push(3)
# pq.push(7)
# p pq
# p pq.pop
# p pq.pop
# p pq.pop
# p pq.size
# p pq.pop

require "spec"

describe PriorityQueue do
  describe "priorityque" do
    it "is priorityque" do
      pq = PriorityQueue(Int32).new
      pq.push(5)
      pq.push(10)
      pq.push(3)
      pq.push(7)
      pq.size.should eq 4
      pq.pop.should eq 3
      pq.size.should eq 3
      pq.pop.should eq 5
      pq.top.should eq 7
      pq.min.should eq 7
      pq.pop.should eq 7
      pq.any?.should eq true
      pq.pop.should eq 10
      pq.empty?.should eq true
    end
  end
  describe "priorityque" do
    it "is priorityque" do
      n = 100
      r = Array.new(n){|i| i }.shuffle
      pq0 = r.to_pq
      pq1 = PriorityQueue(Int32).new
      r.each{|e| pq1.push(e) }
      pq0.size.should eq n
      pq1.size.should eq n
      n.times{ pq0.pop.should eq pq1.pop }
      #n.times{|i| pq0.pop.should eq i }
      #n.times{|i| pq1.pop.should eq i }
    end
  end
end

# ABC137
# n, m = read_line.split.map(&.to_i)
# ws = Array.new(m + 1) { [] of Int32 }
# n.times do
#   a, b = read_line.split.map(&.to_i)
#   if a <= m
#     ws[a] << b
#   end
# end
# q = PriorityQueue(Int32).new
# ans = 0
# 1.upto(m) do |i|
#   ws[i].each { |v| q.push(-v) }
#   if q.size > 0
#     ans -= q.pop
#   end
# end
# puts ans

# PAST002
# n = gets.to_s.to_i
# ws = Array.new(n + 1) { [] of Int32 }
# n.times do
#   a, b = gets.to_s.split.map{|i|i.to_i}
#   ws[a] << b
# end
# q = PriorityQueue(Int32).new
# ans = 0
# 1.upto(n) do |i|
#   ws[i].each { |v| q.push(-v) }
#   p q
#   if q.size > 0
#     ans -= q.pop.not_nil!
#   end
#   puts ans
# end

# 蟻本 2-4 p.71
# AtCoder ABC137 D - Summer Vacation
# AtCoder PAST002 F - タスクの消化
