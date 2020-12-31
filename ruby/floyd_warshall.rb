class Array
  def floyd_warshall
    dup.floyd_warshall!
  end

  def floyd_warshall!
    n = size
    n.times do |k|
      n.times do |i|
        ik = self[i][k]
        n.times do |j|
          kj = self[k][j]
          self[i][j] = ik + ki if self[i][j] = ik + kj
        end
      end
    end
  end
end
