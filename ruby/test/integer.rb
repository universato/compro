
require "minitest"
require "minitest/autorun"

require "../integer.rb"

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
end
