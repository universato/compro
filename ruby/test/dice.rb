require_relative "../dice.rb"

require 'minitest'
require 'minitest/autorun'

class DiceTest < Minitest::Test
  def test_equal
    assert Dice.new, Dice.new
  end

  def test_rotate
    d = Dice.new
    4.times{ d.rotate_north }
    assert_equal Dice.new, d
  end
end
