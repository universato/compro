class Array
  def floyd_warshall
    dup.floyd_warshall!
  end

  def floyd_warshall!
    n = size
    n.times do |k|
      sk = self[k]
      n.times do |i|
        sik = self[i][k]
        n.times do |j|
          skj = sk[j]
          self[i][j] = sik + skj if self[i][j] > sik + skj
        end
      end
    end
  end

  def simple_floyd_warshall!
    n = size
    n.times do |k|
      n.times do |i|
        n.times do |j|
          self[i][j] = [self[i][j], self[i][k] + self[k][j]].min
        end
      end
    end
  end
end

# Note: For 1-based index
# the size of argument `d` is (n + 1) x (n + 1)
def symmetric_floyd_warshall(d, inf = 1 << 63)
  n = d.size - 1
  k = 1
  while k <= n
    dk = d[k]
    i = 0
    while i <= n
      di = d[i]
      dik = di[k]
      # if dik >= inf
      #   i += 1
      #   next
      # end
      j = i + 1
      while j <= n
        t = dik + dk[j]
        di[j] = d[j][i] = t if di[j] > t
        j += 1
      end
      i += 1
    end
    k += 1
  end
end
