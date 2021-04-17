# def reverse(a, i, s)

# end

# a = (1..10).to_a
# a[2..5].reverse!
# p a

# p (2 + 7) * 6 / 2
# p (1..7).to_a.permutation.size

testcase_count = gets.to_s.to_i

(1..testcase_count).each do |testcase_number|
  n, c = gets.to_s.split.map(&:to_i)

  min = n - 1
  max = (2 + n) * (n - 1) / 2
  if c < min || max < c
    puts "Case ##{testcase_number}: IMPOSSIBLE"
    next
  end

  c -= (n - 1)

  a = (1..n).to_a
  cc = 2
  i = n - 2
  while 0 <= i && 0 < c
    s = [cc, c + 1].min
    c -= (s - 1)
    a[i, s] = a[i, s].reverse
    cc += 1
    i -= 1
  end

  puts "Case ##{testcase_number}: #{a.join(" ")}"
end

# 2 4 5 3 1
# 1 3 5 4 2
# 1 2 4 5 3
# 1 2 3 5 4
# 1 2 3 4 5

# i = 1...n (1..n-1)
# j = n
# j - i + 1

# n - i + 1(1...n)
# n + 1 + (n-1)*(n-2)/2
# (2 + n) * (n - 1) / 2

# 左の最小値から決めていく。
# 既にソート済みでも、n-1コストかかる。
# 5 ~ 1
# 4 ~ 1
# 3 ~ 1
# 2 ~ 1

# 2 3 2
# 1 2 1

# 3 1 4 2
# 1 3 4 2
# 1 2 4 3
# 1 2 3 4
