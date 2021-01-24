# https://ei1333.github.io/luzhiled/snippets/dp/largest-rectangle.html

# ヒストグラムの最大長方形
# Largest recttangle in historgram
def largest_rectangle(heights)
  st = [] of Int32
  heights << 0
  left = Array(Int32).new(heights.size, -1)
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
