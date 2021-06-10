require_relative '../deque_mini.rb'
# require_relative '../deque_reversible.rb'

require 'minitest'
require 'minitest/autorun'

class DequeTest < Minitest::Test
  def test_typical90_ar_044_example1
    deq = Deque[6, 17, 2, 4, 17, 19, 1, 7]
    deq.unshift(deq.pop)
    deq[6], deq[1] = deq[1], deq[6]
    deq[1], deq[5] = deq[5], deq[1]
    deq[3], deq[4] = deq[4], deq[3]
    assert_equal 4, deq[3]
  end

  def test_typical90_ar_044_example2
    deq = Deque[16, 7, 10, 2, 9, 18, 15, 20, 5]
    deq.unshift(deq.pop)
    deq[0], deq[3] = deq[3], deq[0]
    deq.unshift(deq.pop)
    deq[7], deq[4] = deq[4], deq[7]
    deq.unshift(deq.pop)
    assert_equal 18, deq[5]
  end

  def test_typical90_ar_044_example3
    deq = Deque[23, 92, 85, 34, 21, 63, 12, 9, 81, 44, 96]
    assert_equal 44, deq[9]
    assert_equal 21, deq[4]
    deq[2], deq[3] = deq[3], deq[2]
    deq.unshift(deq.pop)
    deq[3], deq[10] = deq[10], deq[3]
    assert_equal 34, deq[10]
    deq[2], deq[4] = deq[4], deq[2]
    deq.unshift(deq.pop)
    deq.unshift(deq.pop)
    assert_equal 63, deq[8]
    deq.unshift(deq.pop)
    assert_equal 85, deq[5]
    assert_equal 63, deq[9]
    deq.unshift(deq.pop)
    assert_equal 21, deq[9]
    assert_equal 34, deq[3]
    assert_equal 96, deq[4]
  end

  def test_typical90_ar_044_example1
    deq = Deque[6, 17, 2, 4, 17, 19, 1, 7]
    deq.unshift(deq.pop)
    deq[6], deq[1] = deq[1], deq[6]
    deq[1], deq[5] = deq[5], deq[2]
    deq[3], deq[4] = deq[4], deq[3]
    assert_equal 4, deq[3]
  end

  def test_typical90_ar_044_example1_details
    deq = Deque[6, 17, 2, 4, 17, 19, 1, 7]
    deq.unshift(deq.pop)
    assert_equal Deque[7, 6, 17, 2, 4, 17, 19, 1], deq
    deq[6], deq[1] = deq[1], deq[6]
    assert_equal Deque[7, 19, 17, 2, 4, 17, 6, 1], deq
    deq[1], deq[5] = deq[5], deq[1]
    assert_equal Deque[7, 17, 17, 2, 4, 19, 6, 1], deq
    deq[3], deq[4] = deq[4], deq[3]
    assert_equal Deque[7, 17, 17, 4, 2, 19, 6, 1], deq
    assert_equal 4, deq[3]
  end

  def test_new
    assert_equal Deque.new, Deque[]
    assert_equal Deque.new([]), Deque[]
    assert_equal Deque.new([1, 2, 3]), Deque[1, 2, 3]
  end

  def test_size
    d = Deque[]
    assert_equal 0, d.size
    d.pop
    assert_equal 0, d.size
    d.shift
    assert_equal 0, d.size
    d.push(2)
    assert_equal 1, d.size
    d.unshift(nil)
    assert_equal 2, d.size
    d.push('a')
    assert_equal 3, d.size
    d.pop
    assert_equal 2, d.size
    d.shift
    assert_equal 1, d.size
  end

  def test_empty?
    d = Deque[]
    assert d.empty?
    d.push(1)
    refute d.empty?

    d = Deque[1, 2, 3]
    refute d.empty?
    d.shift
    d.pop
    d.shift
    assert d.empty?
  end

  def test_push
    d = Deque[]
    assert_equal Deque[1], d.push(1)
    # assert_equal Deque[1, 2, 3], d.push(2, 3)
  end

  def test_unshift
    d = Deque[]
    assert_equal Deque[1], d.unshift(1)
    assert_equal Deque[2, 1], d.unshift(2)
    # assert_equal Deque[3, 2, 1], d.prepend(3)
  end

  def test_pop
    d = Deque[1, 2, 3]
    assert_equal 3, d.pop
    assert_equal 2, d.pop
    assert_equal 1, d.pop
  end

  def test_pop_empty
    d = Deque[]
    assert_nil d.pop
  end

  def test_shift
    d = Deque[1, 2, 3]
    assert_equal 1, d.shift
    assert_equal 2, d.shift
    assert_equal 3, d.shift
  end

  def test_empty_shift
    d = Deque[1, 2, 3]
    assert_equal 1, d.shift
    assert_equal 2, d.shift
    assert_equal 3, d.shift
    assert_nil d.shift
    assert_nil d.shift

    d = Deque[]
    assert_nil d.shift
    assert_nil d.shift
  end

  def test_slice1
    d = Deque[:a, :b, :c, :d]
    assert_equal :d, d[-1]
    assert_equal :a, d[-4]
    assert_equal :b, d[1]
    assert_equal :c, d[2]
    d.push(:e)
    d.unshift(:z)
    assert_equal :a, d[1]
  end

  def test_slice_out_of_range
    d = Deque[]
    # assert_nil d[0]
    # assert_nil d[-1]
  end

  def test_slice_assignment
    d = Deque[:a, :b, :c, :d]
    d[0] = 10
    assert_equal Deque[10, :b, :c, :d], d
    d[-1] = 40
    assert_equal Deque[10, :b, :c, 40], d
    d.pop
    d[-1] = 30
    d.push(:x)
    assert_equal Deque[10, :b, 30, :x], d
  end

  def test_to_a
    assert_equal [], Deque[].to_a
    assert_equal [1, 2, 3], Deque[1, 2, 3].to_a

    d = Deque[]
    d.push(1)
    assert_equal [1], d.to_a
    d.unshift(2)
    assert_equal [2, 1], d.to_a
  end

  def test_to_s
    assert_equal "Deque[]", Deque[].to_s
    assert_equal "Deque[1, 2, 3]", Deque[1, 2, 3].to_s
    # assert_equal "Deque[]", Deque[].inspect
    # assert_equal "Deque[1, 2, 3]", Deque[1, 2, 3].inspect

    assert_output("Deque[1, 2, 3]\n"){ puts Deque[1, 2, 3] }
    # assert_output("Deque[1, 2, 3]\n"){ p Deque[1, 2, 3] }
    # assert_output("Deque[1, 2, 3]\n"){ pp Deque[1, 2, 3] }
  end
end

# if __FILE__ == $0
#   # p $0
# end

# require "benchmark"
# n = 10**4
# m = 10**5
# a = [0] * m
# Benchmark.bm do |r|
#   r.report{ n.times{ a[0] = 0; a.unshift(a.pop) } }
#   r.report{ d = Deque.new(a); n.times{ d[0] = 0; d.unshift(d.pop) } }
# end

# require "benchmark"
# n = 10**4
# m = 10**5
# a = [0] * m
# Benchmark.bm do |r|
#   r.report{ n.times{ a[0] = 0; a.pop } }
#   r.report{ d = Deque.new(a); n.times{ d[0] = 0; d.pop } }
# end

# require "benchmark"
# n = 10**4
# m = 10**5
# a = [0] * m
# Benchmark.bm do |r|
#   r.report{ n.times{ a[0] = 0; a.unshift(2) } }
#   r.report{ d = Deque.new(a); n.times{ d[0] = 0; d.unshift(2) } }
# end
