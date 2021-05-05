require 'minitest'
require 'minitest/autorun'

require_relative '../parentheses.rb'

class TestParentheses < MiniTest::Test
  def test_string
    assert "".balanced?
    assert "()".balanced?
    assert "()()".balanced?
    assert "(())".balanced?
    assert ("()" * 10**5).balanced?

    refute "(".balanced?
    refute ")".balanced?
    refute ")(".balanced?
    refute "(()(".balanced?
  end

  def test_array
    assert [].balanced?
    assert [1, -1].balanced?
    assert [1, -1, 1, -1].balanced?

    refute [1].balanced?
    refute [-1].balanced?
    refute [-1, 1].balanced?
  end
end
