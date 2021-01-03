require 'minitest/autorun'
require_relative '../priority_queue.rb'

class PriorityQueueTest < Minitest::Test
  def test_pq
    pq = PriorityQueue.new
    assert_equal 0, pq.size
    assert pq.empty?
    assert_nil pq.top
    assert_nil pq.pop
    pq.push(20)
    pq.push(1)
    pq.push(300)
    assert_equal 1, pq.top
    assert_equal 1, pq.pop
    assert_equal 20, pq.top
    assert_equal 2, pq.size
    assert pq.any?
  end

  def test_third
    n = 100
    pq = Array.new(n){ |i| i }.shuffle.to_pq
    assert_equal 0, pq.first
    assert_equal 1, pq.second
    assert_equal 2, pq.third
  end

  def test_suhhle_array
    n = 100
    pq = Array.new(n){ |i| i }.shuffle.to_pq
    assert_equal n, pq.size
    assert_equal 0, pq.top
    n.times{ |i| assert_equal i, pq.pop }
    assert pq.empty?
  end

  def test_suhhle_array2
    n = 100
    pq = Array.new(n){ |i| [i, 0] }.shuffle.to_pq
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
    n.times{ |_i| assert_equal pq0.pop, pq1.pop }
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

# 蟻本 2-4 p.71
# AtCoder ABC137 D - Summer Vacation
# AtCoder PAST002 F - タスクの消化
