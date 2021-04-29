require 'minitest'
require 'minitest/autorun'

require_relative '../matrix.rb'

class TestMatrix < MiniTest::Test
  def setup
    @mz = Matrix.new(0, 0, 0, 0)
    @m1 = Matrix.new(1, 1, 1, 1)
    @m = Matrix.new(1, 2, 3, 4)
    @m = Matrix.new(1, 2, 3, 4)
  end

  def test_identity
    assert_equal Matrix.new(1, 0, 0, 1), Matrix.I
    assert_equal Matrix.new(1, 0, 0, 1), Matrix.identity
    assert_equal Matrix.new(1, 0, 0, 1), Matrix.unit
    assert_equal Matrix.new(1, 0, 0, 1), Matrix.eye
  end

  def test_zeros?
    assert Matrix.new(0, 0, 0, 0).zero?
    assert Matrix.zeros.zero?

    refute Matrix.I.zero?
  end

  def test_transpose
    assert_equal Matrix.I, Matrix.I.t
    assert_equal Matrix.zeros, Matrix.zeros.t
    assert_equal Matrix.ones, Matrix.ones.t
    assert_equal Matrix.new(1, 3, 2, 4), Matrix.new(1, 2, 3, 4).t
  end

  def test_zeros
    assert_equal Matrix.new(0, 0, 0, 0), Matrix.zeros
    assert_equal Matrix.new(0, 0, 0, 0), Matrix.zero
  end

  def test_ones
    assert_equal Matrix.new(1, 1, 1, 1), Matrix.ones
    assert_equal Matrix.new(1, 1, 1, 1), Matrix.one
  end

  def test_equal
    assert @m == @m
    assert Matrix.new(0, 0, 0, 0) == Matrix.new(0.0, 0.0, 0.0, 0.0)
    assert Matrix.new(1, 2, 3, 4) == Matrix.new(1.0, 2.0, 3.0, 4.0)
    assert Matrix.new(0.0, 1.0, 2.0, 3.0) == Matrix.new(0, 1, 2, 3)

    refute @m == Matrix.new(99, 99, 99, 99)
    refute Matrix.new(99, 99, 99, 99) == @m
  end

  def test_det
    assert_equal 0, Matrix.new(0, 0, 0, 0).det
    assert_equal 1, Matrix.new(1, 0, 0, 1).det
    assert_equal 0, Matrix.new(1, 1, 1, 1).det
  end

  def test_tr
    assert_equal 0, Matrix.new(0, 0, 0, 0).tr
    assert_equal 2, Matrix.new(1, 0, 0, 1).tr
    assert_equal 2, Matrix.new(1, 1, 1, 1).tr
    assert_equal 5, Matrix.new(1, 2, 3, 4).tr
  end

  def test_add
    zeros = Matrix.new(0, 0, 0, 0)
    assert_equal @m, @m + zeros
    assert_equal @m, zeros + @m
  end

  def test_mul_matrix
    m1 = Matrix.new(1, 2, 3, 4)
    m2 = Matrix.new(5, 6, 7, 8)
    assert_equal Matrix.new(19, 22, 43, 50), m1 * m2
    assert_equal m1, m1 * Matrix.I
    assert_equal m2, m2 * Matrix.I
    assert_equal m1, Matrix.I * m1
    assert_equal m2, Matrix.I * m2
  end

  def test_diagonal?
    assert Matrix.I.diagonal?
    assert Matrix.identity.diagonal?
    assert Matrix.zeros.diagonal?

    refute Matrix.ones.diagonal?
  end

  def test_map
    # assert_equal 0, Matrix.new(0, 0, 0, 0).det
    # assert_equal 1, Matrix.new(1, 0, 0, 1).det
    assert_equal Matrix.new(2, 4, 6, 8), Matrix.new(1, 2, 3, 4).map{ |e| e * 2 }
    assert_equal Matrix.new(-1, -2, -3, -4), Matrix.new(1, 2, 3, 4).map{ |e| -e }
  end

  def test_giagonal?
    assert Matrix.zeros.diagonal?
    assert Matrix.new(0, 0.0, 0/1r, 0+0i).diagonal?
  end

  def test_square?
    assert Matrix.zeros.square?
    assert Matrix.I.square?
    assert @m.square?
  end

  def test_symmetric?
    assert Matrix.I.square?
    assert Matrix.zeros.square?
    assert Matrix.ones.square?

    refute Matrix.new(1, 2, 3, 4).symmetric?
  end

  def test_sum
    assert_equal 2, Matrix.I.sum
    assert_equal 0, Matrix.zeros.sum
    assert_equal 4, Matrix.ones.sum

    assert_equal 10, Matrix.new(1, 2, 3, 4).sum
    assert_equal 10.0, Matrix.new(1.0, 2.0, 3.0, 4.0).sum
  end

  def test_upper_triangular?
    assert Matrix.I.upper_triangular?
    assert Matrix.zeros.upper_triangular?
  end

  def test_lower_triangular?
    assert Matrix.I.lower_triangular?
    assert Matrix.zeros.lower_triangular?
  end

  def test_row_vectors
    assert_equal [Vector.new(1, 2), Vector.new(3, 4)], Matrix.new(1, 2, 3, 4).row_vectors
  end

  def test_nnz
    assert 0, Matrix.zeros.nnz
    assert 2, Matrix.I.nnz
    assert 4, Matrix.ones.nnz
  end
end

class TestVector < MiniTest::Test
  def test_zeros
    # assert_equal Vector.new(0, 0), Vector.zeros
    # assert_equal Vector.new(0, 0), Vector.zero
  end

  def test_zeros
    # assert_equal Vector.new(1, 1), Vector.ones
    # assert_equal Vector.new(1, 1), Vector.one
  end

  def test_mul_num
    assert_equal Vector.new(2, 4), Vector.new(1, 2) * 2
    assert_equal Vector.new(-2, -4), Vector.new(1, 2) * -2
  end

  def test_div
    assert_equal Vector.new(0.5, 1.0), Vector.new(1, 2) / 2.0
    assert_equal Vector.new(-0.5, -1.0), Vector.new(1, 2) / -2.0
  end

  def test_quo
    assert_equal Vector.new(0.5, 1.0), Vector.new(1, 2) / 2.0
    assert_equal Vector.new(-0.5, -1.0), Vector.new(1, 2) / -2.0
  end

  def test_nnz
    assert_equal 0, Vector.new(0, 0).nnz
    assert_equal 1, Vector.new(10, 0).nnz
    assert_equal 1, Vector.new(0, 50).nnz
    assert_equal 2, Vector.new(10, 1).nnz
  end

  def test_to_a
    assert_equal [0, 0], Vector.new(0, 0).to_a
    assert_equal [10, 0], Vector.new(10, 0).to_a
    assert_equal [0, 50], Vector.new(0, 50).to_a
    assert_equal [10, 1], Vector.new(10, 1).to_a
  end

  def test_sum
    assert_equal 0, Vector.new(0, 0).sum
    assert_equal 10, Vector.new(10, 0).sum
    assert_equal 50, Vector.new(0, 50).sum
    assert_equal 11, Vector.new(10, 1).sum
    assert_equal 11.0, Vector.new(10.0, 1.0).sum
  end

  def test_diff
    assert_equal 0, Vector.new(0, 0).diff
    assert_equal -10, Vector.new(10, 0).diff
    assert_equal 50, Vector.new(0, 50).diff
    assert_equal -9, Vector.new(10, 1).diff
    assert_equal -9.0, Vector.new(10.0, 1.0).diff
  end

  def test_rot90
    assert_equal Vector.new(0, 1), Vector.new(1, 0).rot90
    assert_equal Vector.new(-1, 0), Vector.new(0, 1).rot90
    assert_equal Vector.new(1.0, 0.0), Vector.new(0.0, -1.0).rot90
  end

  def test_clock90
    assert_equal Vector.new(0, -1), Vector.new(1, 0).clock90
    assert_equal Vector.new(-1, 0), Vector.new(0, -1).clock90
  end

  def test_first
    assert_equal 1, Vector.new(1, 0).first
    assert_equal 0, Vector.new(0, -1).first
  end

  def test_last
    assert_equal 5, Vector.new(5, 0).first
    assert_equal 100, Vector.new(100, 99).first
  end

  def test_slice
    assert_equal 5, Vector.new(5, 0)[0]
    assert_equal 5, Vector.new(5, 0)[-2]
    assert_equal 10, Vector.new(9, 10)[1]
    assert_equal 10, Vector.new(9, 10)[-1]
    assert_nil Vector.new(9, 10)[10]
    assert_nil Vector.new(9, 10)[-10]
  end

  def test_size
    assert_equal 2, Vector.new(5, 0).size
    assert_equal 2, Vector.new(5, 100).size
  end

  def test_length
    assert_equal 2, Vector.new(5, 0).length
    assert_equal 2, Vector.new(5, 100).length
  end

  def test_zero?
    assert Vector.new(0, 0).zero?
    refute Vector.new(100, 99).zero?
  end

  def test_clone
    assert Vector.new(0, 1), Vector.new(0, 1).clone
    assert Vector.new(1, 0), Vector.new(1, 0).clone
  end

  def test_dup
    assert Vector.new(0, 1), Vector.new(0, 1).dup
    assert Vector.new(1, 0), Vector.new(1, 0).dup
  end
end
