require_relative '../floyd_warshall.rb'

require 'minitest'
require 'minitest/autorun'

# FloydWarshallTest
class FloydWarshallTest < Minitest::Test
  def test_floyd_warsha
    inf = 10**2
    d = [
      [  0, inf, inf, inf],
      [inf,   0,   3, inf],
      [inf,   3,   0,   3],
      [inf, inf,   3,   0],
    ]

    expected = [
      [  0, inf, inf, inf],
      [inf,   0,   3,   6],
      [inf,   3,   0,   3],
      [inf,   6,   3,   0],
    ]
    assert_equal expected, d.floyd_warshall
  end
end

# FloydWarshallTest
class SymetricFloydWarshallTest < Minitest::Test
  def test_abc143_e_sample1
    inf = 10**9 + 1
    d = [
      [inf, inf, inf, inf],
      [inf, inf,   3, inf],
      [inf,   3, inf,   3],
      [inf, inf,   3, inf],
    ]

    expected = [
      [inf, inf, inf, inf],
      [inf, inf,   3,   6],
      [inf,   3, inf,   3],
      [inf,   6,   3, inf],
    ]

    symmetric_floyd_warshall(d)
    assert_equal expected, d

    d = [
      [inf, inf, inf, inf],
      [inf, inf,   1, inf],
      [inf,   1, inf,   1],
      [inf, inf,   1, inf],
    ]
    expected = [
      [inf, inf, inf, inf],
      [inf, inf,   1,   2],
      [inf,   1, inf,   1],
      [inf,   2,   1, inf],
    ]
  end

  def test_abc143_e_sample2
    inf = 10**9 + 1
    d = Array.new(4 + 1){ [inf] * (4 + 1) }
    expected = d.map{ |a| a.dup }

    symmetric_floyd_warshall(d)
    assert_equal expected, d
  end

  def test_abc143_e_sample3
    inf = 10**9 + 1
    d = [
      [inf, inf, inf, inf, inf, inf],
      [inf, inf,   2, inf, inf, inf],
      [inf,   2, inf,   2, inf, inf],
      [inf, inf,   2, inf,   3, inf],
      [inf, inf, inf,   3, inf,   2],
      [inf, inf, inf, inf,   2, inf],
    ]

    expected = [
      [inf, inf, inf, inf, inf, inf],
      [inf, inf,   2,   4,   7,   9],
      [inf,   2, inf,   2,   5,   7],
      [inf,   4,   2, inf,   3,   5],
      [inf,   7,   5,   3, inf,   2],
      [inf,   9,   7,   5,   2, inf],
    ]

    symmetric_floyd_warshall(d)
    assert_equal expected, d

    d = [
      [inf, inf, inf, inf, inf, inf],
      [inf, inf,   1,   1, inf, inf],
      [inf,   1, inf,   1, inf, inf],
      [inf,   1,   1, inf,   1, inf],
      [inf, inf, inf,   1, inf,   1],
      [inf, inf, inf, inf,   1, inf],
    ]

    expected = [
      [inf, inf, inf, inf, inf, inf],
      [inf, inf,   1,   1,   2,   3],
      [inf,   1, inf,   1,   2,   3],
      [inf,   1,   1, inf,   1,   2],
      [inf,   2,   2,   1, inf,   1],
      [inf,   3,   3,   2,   1, inf],
    ]
    symmetric_floyd_warshall(d)
    assert_equal expected, d
  end
end
