require_relative '../float.rb'

require 'minitest'
require 'minitest/autorun'

# FloatTest
class FloatTest < Minitest::Test
  def test_float_as_binary
    s = "01111111111" + "0" * 52
    b = s.to_i(2)
    assert_equal 1, Float.f64(b)

    s = "01111111111" + "1".ljust(52, '0')
    b = s.to_i(2)
    assert_equal 1.5, Float.f64(b)

    s = "0" + "1" * 11 + '0' * 52
    b = s.to_i(2)
    assert_equal Float::INFINITY, Float.f64(b)

    s = "1" + "1" * 11 + '0' * 52
    b = s.to_i(2)
    assert_equal (-Float::INFINITY), Float.f64(b)

    s = "0" + "0" * 11 + '0' * 52
    b = s.to_i(2)
    assert_equal 0.0, Float.f64(b)

    s = "1" + "0" * 11 + '0' * 52
    b = s.to_i(2)
    assert_equal -0.0, Float.f64(b)
  end
end
