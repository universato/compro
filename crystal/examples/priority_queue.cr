require "../priority_queue.cr"

# pq = PriorityQueue(Int32).new
# pq.push(5)
# pq.push(10)
# pq.push(3)
# pq.push(7)
# p pq
# p pq.pop
# p pq.pop
# p pq.pop
# p pq.size
# p pq.pop

def abc137
  # ABC137
  n, m = read_line.split.map(&.to_i)
  ws = Array.new(m + 1) { [] of Int32 }
  n.times do
    a, b = read_line.split.map(&.to_i)
    if a <= m
      ws[a] << b
    end
  end
  q = PriorityQueue(Int32).new
  ans = 0
  1.upto(m) do |i|
    ws[i].each { |v| q.push(-v) }
    if q.size > 0
      ans -= q.pop
    end
  end
  puts ans
end

def past002
  # PAST002
  n = gets.to_s.to_i
  ws = Array.new(n + 1) { [] of Int32 }
  n.times do
    a, b = gets.to_s.split.map{|i|i.to_i}
    ws[a] << b
  end
  q = PriorityQueue(Int32).new
  ans = 0
  1.upto(n) do |i|
    ws[i].each { |v| q.push(-v) }
    p q
    if q.size > 0
      ans -= q.pop.not_nil!
    end
    puts ans
  end
end

# 蟻本 2-4 p.71
# AtCoder ABC137 D - Summer Vacation
# AtCoder PAST002 F - タスクの消化
