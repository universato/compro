def floor_sum(n, m, a, b)
  res = 0_i64

  if a >= m
    res += (n - 1) * n * (a // m) // 2
    a %= m
  end

  if b >= m
    res += n * (b // m)
    b %= m
  end

  y_max = (a * n + b) // m
  x_max = (y_max * m - b)

  return res if y_max == 0

  res += (n - (x_max + a - 1) // a) * y_max
  res += floor_sum(y_max, a, m, (a - x_max % a) % a)
  res
end

t = gets.to_s.to_i

t.times do
  n, m, a, b = gets.to_s.split.map { |e| e.to_i64 }
  puts floor_sum(n, m, a, b)
end
