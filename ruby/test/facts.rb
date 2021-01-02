
require 'minitest'
require 'minitest/autorun'

require_relative '../facts.rb'

# FactsTest
class FactsTest < Minitest::Test
  def test_cmb
    f = Facts.new
    assert_equal 0, f.cmb(10, -1)
    assert_equal 1, f.cmb(10, 0)
    assert_equal 10, f.cmb(10, 1)
    assert_equal 45, f.cmb(10, 2)
    assert_equal 120, f.cmb(10, 3)
    assert_equal 120, f.cmb(10, 7)
    assert_equal 45, f.cmb(10, 8)
    assert_equal 10, f.cmb(10, 9)
    assert_equal 1, f.cmb(10, 10)
    assert_equal 0, f.cmb(10, 11)
    assert_equal f.cmb(500, 100), f.cmb(500, 400)
    assert_equal f.cmb(1000, 100), f.cmb(1000, 900)
  end

  def test_factorial
    f = Facts.new
    assert_equal 1, f.factorial(0)
    assert_equal 1, f.factorial(1)
    assert_equal 2, f.factorial(2)
    assert_equal 6, f.factorial(3)
    assert_equal 24, f.factorial(4)
    assert_equal 120, f.factorial(5)
    assert_equal 720, f.factorial(6)
  end

  def test_hom
    mod = 10**9 + 7
    f = Facts.new
    # assert_equal 607923868, f.hom(200000,1000000000)
    n = rand(1..100)
    k = n + rand(1..100)
    assert_equal f.hom(n, n), (0..k).reduce(0){ |s, i| s += f.cmb(n, i) * f.hom(n - i, i) % mod } % mod
  end

  def test_prm
    f = Facts.new
    assert_equal 1, f.prm(5, 0)
    assert_equal 5, f.prm(5, 1)
    assert_equal 20, f.prm(5, 2)
    assert_equal 60, f.prm(5, 3)
    assert_equal 120, f.prm(5, 4)
    assert_equal 120, f.prm(5, 5)
  end

  def test_catalan_number
    f = Facts.new
    assert_equal 1, f.catalan_number(0)
    assert_equal 1, f.catalan_number(1)
    assert_equal 2, f.catalan_number(2)
    assert_equal 5, f.catalan_number(3)
    assert_equal 42, f.catalan_number(5)
    assert_equal 16_796, f.catalan_number(10)
    assert_equal 9_694_845, f.catalan_number(15)
  end
end
