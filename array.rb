class Array
  include Comparable
end

require 'minitest/autorun'

class Array_Test < Minitest::Test
  def test_comparison_operator
    assert [1,2,3] < [3,4,5]
    assert [3,4,5] > [1,2,3]
    assert [1,1,1] == [1,1,1]
    assert [1,1] < [1,1,1]
    assert [1,2] > [1,1,1]
    assert [1,1] <= [1,1,1]
    assert [1,2] >= [1,1,1]
  end
end
