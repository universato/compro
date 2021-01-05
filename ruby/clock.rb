Math::TAU = Math::PI * 2

class Clock
  def initialize(h = 0, m = 0, s = 0)
    @h = h
    @m = m
    @s = s
  end

  def adjust
    (m = @h - @h.to_i) != 0 and add_minute(m * 60)
    (s = @m - @m.to_i) != 0 and add_second(s * 60)
    @m += @s / 60 and @s %= 60
    @h += @m / 60 and @m %= 60
    @h %= 24
  end

  def radian_between_hour_hand_and_minute_hand
    r = (ratio_of_hour_hand - ratio_of_minute_hand).abs
    Math::TAU * [1 - r, r].min
  end

  def degrees_between_hour_hand_and_minute_hand
    r = (ratio_of_hour_hand - ratio_of_minute_hand).abs
    360 * [1 - r, r].min
  end

  def how_many_minutes_to_wait_for_coincidence_of_hour_hand_and_minute_hand
    d = ratio_of_hour_hand - ratio_of_minute_hand
    d += 1 if d <= 0
    d / (Rational(1, 60) - Rational(1, 60 * 12))
  end

  def ratio_of_hour_hand
    Rational(@h % 12, 12) + Rational(@m % 60, 60 * 12) + Rational(@s % 60, 12 * 60 * 60)
  end

  def ratio_of_minute_hand
    Rational(@m % 60, 60) + Rational(@s % 60, 60 * 60)
  end

  def add_duration(h, m, s)
    add_hour(h)
    add_minute(m)
    add_second(s)
  end

  def add_hour(h)
    if (m = h - h.to_i) != 0
      add_minute(m * 60)
    end
    @h += h.to_i
  end

  def add_minute(m)
    if (s = m - m.to_i) != 0
      add_second(s * 60)
    end
    @m += m.to_i
    @h += @m / 60 if @m >= 60
    @m %= 60
  end

  def add_second(s)
    @s += s
    add_minute(@s / 60) if @s >= 60
    @s %= 60
  end
end

def abc168_c
  # https://atcoder.jp/contests/abc168/tasks/abc168_c

  a, b, h, m = gets.to_s.split.map(&:to_f)

  clock = Clock.new(h, m)
  r = clock.radian_between_hour_hand_and_minute_hand
  ans = (a**2 + b**2 - 2 * a * b * Math.cos(r))**0.5

  puts ans
end

# clock = Clock.new(12, 0o0)
# clock.add_hour(10.5)
# p clock
# tmp = clock.how_many_minutes_to_wait_for_coincidence_of_hour_hand_and_minute_hand
# p ( tmp / 60)
