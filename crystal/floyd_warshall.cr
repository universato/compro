macro chmin(x, y)
  {{x}} = {{y}} if {{x}} > {{y}}
end

def floyd_warshall(m)
  n = m.size

  n.times do |k|
    n.times do |i|
      n.times do |j|
        chmin(m[i][j], m[i][k] + m[k][j])
      end
    end
  end

  m
end
