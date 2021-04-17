testcase_count = gets.to_s.to_i

(1..testcase_count).each do |testcase_number|
  x, y, s = gets.to_s.split
  x = x.to_i
  y = y.to_i

  s.squeeze!('CJ')
  s = s.chars
  s.shift while s[0] == '?'
  s.pop while s[-1] == '?'

  ans = 0
  s.each_cons(2) do |c1, c2|
    if c1 == "C" && c2 == "J"
      ans += x
    elsif c1 == "J" && c2 == "C"
      ans += y
    end
  end

  n = s.size
  t = []
  i = 0
  while s.any?
    if s[0] == '?'
      i += 1
      s.shift
    else
      if i > 0
        t.push(i)
        i = 0
      end
      t.push(s.shift)
    end
  end

  t.each_with_index do |c, i|
    if c.is_a?(Integer)
      if t[i - 1] == 'C' && t[i + 1] == "J"
        ans += x
      elsif t[i - 1] == 'J' && t[i + 1] == "C"
        ans += y
      end
    end
  end

  puts "Case ##{testcase_number}: #{ans}"
end

# C?J -> CCJ(X) CJJ(Y)
# ??J -> JJJ(0)
# 両脇の？は無視してよい。
# CとJの連続も無視してよい。
# CとCに挟まれた'?'も無視してよい。
# CとJに挟まれた'?'なら、どこかで切り替えが生じる。
# 切り替えのタイミングでコストが生じる。避けられない。
# CJ JCは普通に数えて、それ以外の?の数と前後を数える。
# C??J?J??C
# C?J
# C???J

# CCCCCJJ


# マイナスありだったら面倒だな。特に両方がマイナスだと面倒そう。
