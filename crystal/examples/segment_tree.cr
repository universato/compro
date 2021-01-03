

def abc125
  #  ABC125 C - GCD on Blackboard
  n = gets.to_s.to_i64
  a = gets.to_s.split.map{|t| t.to_i64 }

  st = a.to_segment_tree_for_sum

  ans = [st.get_sum(1, n), st.get_sum(0, n-1)].max

  1.upto(n-2) do |i|
    p v = st.get_sum(0, i) + st.get_sum(i+1, n)
    ans = v if ans < v
  end

  puts ans
end
