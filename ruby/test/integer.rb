
require "minitest"
require "minitest/autorun"

require_relative "../integer.rb"

class IntegerTest < Minitest::Test
  def test_pow
    assert_equal 1024, 2.pow(10)
    assert_equal 1024, 2.pow(10, 1_000_000_007)
  end

  def test_ceil_div
    assert_equal 0, 0.ceil_div(2)
    assert_equal 1, 1.ceil_div(2)
    assert_equal 1, 2.ceil_div(2)
    assert_equal 2, 3.ceil_div(2)
    assert_equal 2, 4.ceil_div(2)
    assert_equal 3, 5.ceil_div(2)
    assert_equal 3, 6.ceil_div(2)

    assert_equal 0, 0.ceil_div(3)
    assert_equal 1, 1.ceil_div(3)
    assert_equal 1, 2.ceil_div(3)
    assert_equal 1, 3.ceil_div(3)
    assert_equal 2, 4.ceil_div(3)
    assert_equal 2, 5.ceil_div(3)
    assert_equal 2, 6.ceil_div(3)

    # -2.5を +Inf方向に丸める。+Inf方向に丸める(Julia)
    assert_equal -2, (-5).ceil_div(2)
  end

  # floor divisionに近い。self / other 未満の最大整数
  # ceil division の結果に +1 した結果と同じでは。
  # 未満と以上で対だし、そうかもしれない。
  def test_miman_div
    assert_equal -1, 0.miman_div(2)
    assert_equal 0, 1.miman_div(2)
    assert_equal 0, 2.miman_div(2)
    assert_equal 1, 3.miman_div(2)
    assert_equal 1, 4.miman_div(2)
    assert_equal 2, 5.miman_div(2)
    assert_equal 2, 6.miman_div(2)

    assert_equal -1, 0.miman_div(3)
    assert_equal 0, 1.miman_div(3)
    assert_equal 0, 2.miman_div(3)
    assert_equal 0, 3.miman_div(3)
    assert_equal 1, 4.miman_div(3)
    assert_equal 1, 5.miman_div(3)
    assert_equal 1, 6.miman_div(3)

    # -2.5を +Inf方向に丸める。+Inf方向に丸める(Julia)
    assert_equal -2, (-5).ceil_div(2)
  end

  def test_comb
    assert_equal 1, 10.comb(0)
    assert_equal 10, 10.comb(1)
    assert_equal 45, 10.comb(2)
    assert_equal 120, 10.comb(3)
    assert_equal 1, 10.comb(10)
    assert_equal 10, 10.comb(9)
    assert_equal 45, 10.comb(8)
    assert_equal 120, 10.comb(7)

    assert_equal 1, 10.comb(10, 1_000_000_007)
    assert_equal 10, 10.comb(9, 1_000_000_007)
    assert_equal 45, 10.comb(8, 1_000_000_007)
    assert_equal 120, 10.comb(7, 1_000_000_007)

    # assert_equal 1, 10.comb(0, 3)
    # assert_equal 1, 10.comb(1, 3)
    # assert_equal 0, 10.comb(2, 3)
    # assert_equal 0, 10.comb(3, 3)
    # assert_equal 1, 10.comb(10, 3)
    # assert_equal 1, 10.comb(9, 3)
    # assert_equal 0, 10.comb(8, 3)
    # assert_equal 0, 10.comb(7, 3)
  end

  def test_comb_mod2
    assert_equal 1, 10.comb_mod2(0)   #   1
    assert_equal 0, 10.comb_mod2(1)   #  10
    assert_equal 1, 10.comb_mod2(2)   #  45
    assert_equal 0, 10.comb_mod2(3)   # 120
    assert_equal 1, 10.comb_mod2(10)  #   1
    assert_equal 0, 10.comb_mod2(9)   #  10
    assert_equal 1, 10.comb_mod2(8)   #  45
    assert_equal 0, 10.comb_mod2(7)   # 120

    assert_equal 1, 1.comb_mod2(0) # 1
    assert_equal 1, 1.comb_mod2(1) # 1

    assert_equal 1, 2.comb_mod2(0) # 1
    assert_equal 0, 2.comb_mod2(1) # 2
    assert_equal 1, 2.comb_mod2(2) # 1

    assert_equal 1, 2.comb_mod2(0) # 1
    assert_equal 0, 2.comb_mod2(1) # 2
    assert_equal 1, 2.comb_mod2(2) # 1

    assert_equal 1, 3.comb_mod2(0) # 1
    assert_equal 1, 3.comb_mod2(1) # 3
    assert_equal 1, 3.comb_mod2(2) # 3
    assert_equal 1, 3.comb_mod2(3) # 1

    # 範囲外
    assert_equal 0, 10.comb_mod2(-3) #   0
    assert_equal 0, 10.comb_mod2(-2) #   0
    assert_equal 0, 10.comb_mod2(-1) #   0
    assert_equal 0, 10.comb_mod2(11) #   0
    assert_equal 0, 10.comb_mod2(12) #   0
    assert_equal 0, 10.comb_mod2(13) #   0

    assert_equal 0, 1.comb_mod2(-3) # 0
    assert_equal 0, 1.comb_mod2(-2) # 0
    assert_equal 0, 1.comb_mod2(-1) # 0
    assert_equal 0, 1.comb_mod2(2)  # 0

    # assert_equal 10.comb(0)  % 2, 10.comb_mod2(0)
    # assert_equal 10.comb(1)  % 2, 10.comb_mod2(1)
    # assert_equal 10.comb(2)  % 2, 10.comb_mod2(2)
    # assert_equal 10.comb(3)  % 2, 10.comb_mod2(3)
    # assert_equal 10.comb(10) % 2, 10.comb_mod2(10)
    # assert_equal 10.comb(9)  % 2, 10.comb_mod2(9)
    # assert_equal 10.comb(8)  % 2, 10.comb_mod2(8)
    # assert_equal 10.comb(7)  % 2, 10.comb_mod2(7)

    # assert_equal 50.comb(3) % 2, 50.comb_mod2(3)
    # assert_equal 50.comb(18) , 50.comb_mod2(18)

    # assert_comb_mod2(50, 3)
    # assert_comb_mod2(50, 18)
    # assert_comb_mod2(50, 20)
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

  # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, ……]が何回割れるか。
  def test_de_nankai_wareruka_hairetsu
    # assert_equal "1は無限回割れるので無理         ", 1.de_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1], 2.de_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 1, 0, 0, 1, 0, 0, 2, 0], 3.de_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0], 4.de_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1], 5.de_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], 6.de_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], 7.de_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0], 8.de_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0], 9.de_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], 10.de_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 11.de_nankai_wareruka_hairetsu(10)

    assert_equal [0], 2.de_nankai_wareruka_hairetsu(0)
    # assert_equal [0], 2.de_nankai_wareruka_hairetsu(-1)

    assert_equal 2, 3.de_nankai_wareruka_hairetsu(117)[-1]
    assert_equal 0, 3.de_nankai_wareruka_hairetsu(260)[-1]
    assert_equal 6, 3.de_nankai_wareruka_hairetsu(729)[-1]
  end

  # [0!, 1!, 2!, 3!, 4!, 5!, 6!, 7!, 8!, 9!, 10!, ……]が何回割れるか。
  def test_de_fact_wo_nankai_wareruka_hairetsu
    # assert_equal "1は無限回割れるので無理         ", 1.de_fact_wo_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 1, 1, 3, 3, 4, 4, 7, 7, 8], 2.de_fact_wo_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 1, 1, 1, 2, 2, 2, 4, 4], 3.de_fact_wo_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2], 4.de_fact_wo_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2], 5.de_fact_wo_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1], 6.de_fact_wo_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1], 7.de_fact_wo_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1], 8.de_fact_wo_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1], 9.de_fact_wo_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], 10.de_fact_wo_nankai_wareruka_hairetsu(10)
    assert_equal [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 11.de_fact_wo_nankai_wareruka_hairetsu(10)



    assert_equal [0], 2.de_fact_wo_nankai_wareruka_hairetsu(0)
    # assert_equal [0], 2.de_fact_wo_nankai_wareruka_hairetsu(-1)
  end

  def test_de_warikitta_amari_no_amari_hairetsu
    assert_equal 1, 3.de_warikitta_amari_no_amari_hairetsu(117 + 1)[-1]
    assert_equal 2, 3.de_warikitta_amari_no_amari_hairetsu(260 + 1)[-1]
    assert_equal 1, 3.de_warikitta_amari_no_amari_hairetsu(729 + 1)[-1]
  end
end
