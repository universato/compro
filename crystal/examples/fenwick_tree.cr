def alpc
  n, q = gets.to_s.split.map { |e| e.to_i }
  a    = gets.to_s.split.map { |e| e.to_i64 }

  fw = FenwickTree.new(a)
  q.times do
    r, s, t = gets.to_s.split.map { |e| e.to_i64 }
    r == 0 ? fw.add(s, t) : puts fw.sum(s, t)
  end
end

alpc
