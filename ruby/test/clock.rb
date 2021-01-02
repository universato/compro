require_relative '../clock.rb'

require 'minitest'
require 'minitest/autorun'

# CloackTest
class ClockTest < Minitest::Test
  def test_abc030_b
    # https://atcoder.jp/contests/abc030/tasks/abc030_b

    c = Clock.new(15, 0)
    assert_equal 90, c.degrees_between_hour_hand_and_minute_hand

    c = Clock.new(3, 17)
    assert_equal 3.5, c.degrees_between_hour_hand_and_minute_hand.to_f

    c = Clock.new(0, 0)
    assert_equal 0, c.degrees_between_hour_hand_and_minute_hand.to_f

    c = Clock.new(6, 0)
    assert_equal 180, c.degrees_between_hour_hand_and_minute_hand.to_f

    c = Clock.new(23, 59)
    assert_equal 5.5, c.degrees_between_hour_hand_and_minute_hand.to_f
  end

  def test_abc168_c
    a, b, h, m = 3, 4, 9, 0
    clock = Clock.new(h, m)
    r = clock.radian_between_hour_hand_and_minute_hand
    ans = (a**2 + b**2 - 2 * a * b * Math.cos(r))**0.5

    assert_equal 5.0, ans

    a, b, h, m = 3, 4, 10, 40
    clock = Clock.new(h, m)
    r = clock.radian_between_hour_hand_and_minute_hand
    ans = (a**2 + b**2 - 2 * a * b * Math.cos(r))**0.5

    assert_equal 4.56425719433005567605, ans
  end
end
