def alpc
  # alpc
  n, m = gets.to_s.split.map{ |e| e.to_i }

  l = n * m
  mf = MaxFlow.new(l + 2)

  s = Array.new(n){ gets.to_s.chars }.push Array.new(m + 1, '#')
  move = [[1, 0], [0, 1]]
  n.times do |i|
    m.times do |j|
      next if n <= i || m <= j || s[i][j] != '.'

      f = !(i.odd? ^ j.odd?)
      f ? mf.add_edge(l, i * m + j, 1i64) : mf.add_edge(i * m + j, l + 1, 1i64)
      move.each do |(x, y)|
        x = i + x
        y = j + y
        next if n <= x || m <= y || s[x][y] != '.'
        f ? mf.add_edge(i * m + j, x * m + y, 1i64) : mf.add_edge(x * m + y, i * m + j, 1i64)
      end
    end
  end

  puts mf.flow(l, l + 1)
  mf.calc(l, s, m)
  puts s[0..-2].map{ |e| e.join.chomp }.join("\n")
end

def ants_book
  g = MaxFlow.new(5)
  edges = [{0, 1, 10}, {0, 2, 2}, {1, 2, 6}, {1, 3, 6}, {2, 4, 5}, {3, 2, 3}, {3, 4, 8}]
  edges.each{ |(i, j, c)| g.add_edge(i, j, c.to_i64) }
  # pp g.g
  # p g.pos
  p g.flow(0, 1) # 11
end
