
require "minitest"
require "minitest/autorun"

require_relative "../integer.rb"

class IntegerTest < Minitest::Test
  def test_pow
    assert_equal 1024, 2.pow(10)
    assert_equal 1024, 2.pow(10, 1_000_000_007)
  end

  def test_cmb
    assert_equal 1, 10.cmb(0)
    assert_equal 10, 10.cmb(1)
    assert_equal 45, 10.cmb(2)
    assert_equal 120, 10.cmb(3)
    assert_equal 1, 10.cmb(10)
    assert_equal 10, 10.cmb(9)
    assert_equal 45, 10.cmb(8)
    assert_equal 120, 10.cmb(7)
  end

  def test_divisible_by?
    assert_equal true, 1.divisible_by?(1)
    assert_equal true, 1.divisible_by?(-1)
    assert_equal false, 1.divisible_by?(2)
    assert_equal true, 2.divisible_by?(1)
    assert_equal true, 2.divisible_by?(2)
    assert_equal true, 2.divisible_by?(-1)
    assert_equal true, 2.divisible_by?(-2)

    assert_equal true, 0.divisible_by?(-3)
    assert_equal true, 0.divisible_by?(-2)
    assert_equal true, 0.divisible_by?(-1)
    # assert_equal true, 0.divisible_by?(0)
    assert_equal true, 0.divisible_by?(1)
    assert_equal true, 0.divisible_by?(2)
    assert_equal true, 0.divisible_by?(3)
    assert_equal true, 0.divisible_by?(4)
  end

  def test_divisor_of?
    assert_equal true, 1.divisor_of?(1)
    assert_equal true, -1.divisor_of?(1)
    assert_equal true, 1.divisor_of?(2)
    assert_equal true, 2.divisor_of?(2)
    assert_equal true, -1.divisor_of?(2)
    assert_equal true, -2.divisor_of?(2)

    # 0
    assert_equal true, -3.divisor_of?(0)
    assert_equal true, -2.divisor_of?(0)
    assert_equal true, -1.divisor_of?(0)
    # assert_equal true, 0.divisor_of?(0)
    assert_equal true, 1.divisor_of?(0)
    assert_equal true, 2.divisor_of?(0)
    assert_equal true, 3.divisor_of?(0)
    assert_equal true, 4.divisor_of?(0)
  end

  def test_divisors
    # assert_equal [1], -1.divisors
    # assert_equal [1, 2], -2.divisors
    # assert_equal [], 0.divisors
    assert_equal [1], 1.divisors
    assert_equal [1, 2], 2.divisors
    assert_equal [1, 3], 3.divisors
    assert_equal [1, 2, 4], 4.divisors
    assert_equal [1, 5], 5.divisors
    assert_equal [1, 2, 3, 6], 6.divisors
    assert_equal [1, 2, 5, 10], 10.divisors
    assert_equal [1, 3, 5, 15], 15.divisors
    assert_equal [1, 5, 25], 25.divisors
  end

  def test_each_divisor
    # assert_equal [], 0.each_divisor.to_a
    assert_equal [1], 1.each_divisor.to_a
    assert_equal [1, 2], 2.each_divisor.to_a
    assert_equal [1, 3], 3.each_divisor.to_a
    assert_equal [1, 2, 4], 4.each_divisor.to_a
    assert_equal [1, 5], 5.each_divisor.to_a
    assert_equal [1, 2, 3, 6], 6.each_divisor.to_a
    assert_equal [1, 2, 5, 10], 10.each_divisor.to_a
    assert_equal [1, 5, 25], 25.each_divisor.to_a
  end

  def test_modinv
    assert_equal 8, 5.modinv(13)
    assert_equal 4, 3.modinv(11)
    assert_equal 6, 2.modinv(11)
    assert_equal 3, 4.modinv(11)
    assert_equal 9, 5.modinv(11)
    assert_equal 8, 7.modinv(11)
  end

  def test_prm
    assert_equal 2, 2.prm(1)
    assert_equal 2, 2.prm(2)
    assert_equal 5, 5.prm(1)
    assert_equal 20, 5.prm(2)
    assert_equal 60, 5.prm(3)
    assert_equal 120, 5.prm(4)
    assert_equal 120, 5.prm(5)
  end

  def test_lsb
    assert_equal 0, 0.lsb
    assert_equal 1, 1.lsb
    assert_equal 2, 2.lsb
    assert_equal 4, 4.lsb
    assert_equal 8, 8.lsb
    assert_equal 16, 16.lsb
    assert_equal 32, 32.lsb
    assert_equal 64, 64.lsb
    assert_equal 128, 128.lsb

    assert_equal 0b0001, 0b0001.lsb
    assert_equal 0b0001, 0b1001.lsb
    assert_equal 0b0001, 0b1101.lsb
    assert_equal 0b0010, 0b1010.lsb
    assert_equal 0b0010, 0b1110.lsb
    assert_equal 0b0100, 0b1100.lsb
  end
end
