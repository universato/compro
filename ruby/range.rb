class Range
  # [WIP]
  def intersect?(other)
    if exclude_end? ^ other.exclude_end?
      if exclude_end?
        # return false if self.begin == self.end
        # return false if self.end <= other.begin
        # return false if other.end <= self.end
      else
        # return false if other.end == other.begin
        # return false if self.end < other.begin
        # return false if other.end <= self.end
      end
    else
      if exclude_end?
        # return false if self.end == self.begin || other.end == other.begin
        # return false if self.end < other.begin
        # return false if other.end < self.end
      else
        return false if self.end < other.begin
        return false if other.end < self.end
      end
      # l = self.begin > other.begin ? self.begin : other.begin
      # r = self.end < other.end ? self.end : other.end
      # l <= r
    end
    true
  end
end

# intersect
# https://atcoder.jp/contests/abc207/editorial/2152

p (3...4).intersect?(3..5)
p (2...3).intersect?(1..2)

require "minitest"
require "minitest/autorun"
class RangeTest < Minitest::Test
  def test_closed_interval
    assert (1..2).intersect?(2..2)
    assert (1..2).intersect?(2..3)
    assert (2..3).intersect?(3..4)
    refute (-1..2).intersect?(3..4)
    refute (3..4).intersect?(-2..2)
  end

  def test_half_open_interval
    assert (2...3).intersect?(1..2)
    assert (1..2).intersect?(2...3)
    refute (1...2).intersect?(2..2)
    refute (2..2).intersect?(1...2)
  end
end
