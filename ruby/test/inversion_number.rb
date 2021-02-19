
require "minitest"
require "minitest/autorun"

require_relative "../inversion_number.rb"

class InversionNumberTest < Minitest::Test
  def test_inversion_number
    assert_equal 0, inversion_number([])
    assert_equal 0, inversion_number([0, 1, 2, 3, 4, 5])
    assert_equal 0, inversion_number([0, 1, 2, 3, 4, 5, 6])

    assert_equal 0, inversion_number([0, 1, 2, 3])
    assert_equal 3, inversion_number([1, 2, 3, 0])
    assert_equal 4, inversion_number([2, 3, 0, 1])
    assert_equal 3, inversion_number([3, 0, 1, 2])
  end
end
