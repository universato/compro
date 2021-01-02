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
end
