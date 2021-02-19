# https://github.com/magurofly/shed/blob/master/misc/max-rect.rb
# https://ei1333.github.io/luzhiled/snippets/dp/largest-rectangle.html
# うしさんライブラリを写経した感じ

# 計算の都合で引数の最後の要素を0にする必要があって、メソッド内で破壊的に追加している。

def largest_rectangle(heights)
  st = []
  heights << 0
  left = Array.new(heights.size)
  ret = 0
  t = nil
  heights.size.times do |i|
    while !st.empty? && heights[st[-1]] >= heights[i]
      ret = t if ret < (t = (i - left[st[-1]] - 1) * heights[st[-1]])
      st.pop
    end
    left[i] = st.empty? ? -1 : st[-1]
    st.push(i)
  end
  ret
end

def abc189_c
  n = gets.to_s.to_i
  a = gets.to_s.split.map{ |e| e.to_i }

  puts largest_rectangle(a)
end
