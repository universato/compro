# frozen_string_literal: true

require 'minitest'
require 'minitest/autorun'

require_relative '../fenwick_tree.rb'

class FenwickTreeTest < Minitest::Test
  def test_practice_contest
    a = [1, 2, 3, 4, 5]

    ft = FenwickTree.new(a)
    assert_equal 15, ft.sum(0, 5)
    assert_equal 15, ft._sum(5)
    assert_equal 7, ft.sum(2, 4)

    ft.add(3, 10)
    assert_equal 25, ft.sum(0, 5)
    assert_equal 25, ft._sum(5)
    assert_equal 6, ft.sum(0, 3)
    assert_equal 6, ft._sum(3)
  end

  def test_empty
    fw = FenwickTree.new
    assert_equal 0, fw.sum(0, 0)
  end

  def test_zero
    fw = FenwickTree.new(0)
    assert_equal 0, fw.sum(0, 0)
  end

  def test_naive
    (1 .. 50).each do |n|
      fw = FenwickTree.new(n)
      n.times { |i| fw.add(i, i * i) }
      (0 .. n).each do |l|
        (l .. n).each do |r|
          sum = 0
          (l ... r).each { |i| sum += i * i }
          assert_equal sum, fw.sum(l, r)
        end
      end
    end
  end

  def test_only_number
    ft = FenwickTree.new(10)
    assert_equal 0, ft._sum(0)
    assert_equal 0, ft._sum(1)
    assert_equal 0, ft._sum(2)
    assert_equal 0, ft._sum(3)
    assert_equal 0, ft._sum(4)
    assert_equal 0, ft._sum(5)
    assert_equal 0, ft._sum(9)
    assert_equal 0, ft._sum(10)

    assert_equal 0, ft.sum(1, 4)
    assert_equal 0, ft.sum(5, 7)
    assert_equal 0, ft.sum(9, 10)
    assert_equal 0, ft.sum(0, 10)
  end

  def test_syntax_sugar_of_sum
    ft = FenwickTree.new(10)
    assert_equal 0, ft.sum(0)
    assert_equal 0, ft.sum(1)
    assert_equal 0, ft.sum(2)
    assert_equal 0, ft.sum(3)
    assert_equal 0, ft.sum(4)
    assert_equal 0, ft.sum(5)
    assert_equal 0, ft.sum(9)
    assert_equal 0, ft.sum(10)

    assert_equal 0, ft.sum(1..4)
    assert_equal 0, ft.sum(5..7)
    assert_equal 0, ft.sum(9...10)
    assert_equal 0, ft.sum(0...10)

    ft = FenwickTree.new([*0..10])
    assert_equal 45, ft.sum(10)
    assert_equal 55, ft.sum(11)
    assert_equal 55, ft.sum(0..10)
    assert_equal 55, ft.sum(1...11)
  end

  def test_slice
    fw = FenwickTree.new([0, 10, 20, 30, 40])
    assert_equal 0, fw[0]
    assert_equal 10, fw[1]
    assert_equal 20, fw[2]
    assert_equal 30, fw[3]
    assert_equal 40, fw[4]
  end

  def test_init
    n = 10
    a = Array.new(n) { |i| i }

    fwa = FenwickTree.new(a)

    fwi = FenwickTree.new(n)
    a.each_with_index { |e, i| fwi.add(i, e) }

    assert_equal fwi.data, fwa.data
  end
end
