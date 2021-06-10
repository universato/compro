class Array
  def cumsum2d
    h = size
    w = self[0].size
    res = Array.new(h){ [0] * w }
    s = 0; first_row = self[0].map{ |k| s += k }; res[0] = first_row;
    (1...h).each{ |i| res[i][0] = self[i][0] + res[i - 1][0] }
    (1...h).each do |i|
      (1...w).each do |j|
        res[i][j] = self[i][j] + res[i][j - 1] + res[i - 1][j] - res[i - 1][j - 1]
      end
    end
    res
  end

  # self is cumsum2d
  def pond(hk, wk = hk)
    h = size
    w = self[0].size
    raise ArgumentError.new if h < hk || w < wk

    hr = h - hk + 1
    wr = w - wk + 1
    res = Array.new(hr){ [0] * wr }
    (0...hr).each do |i|
      (0...wr).each do |j|
        ii = hk - 1 + i
        jj = wk - 1 + j
        t = self[ii][jj]
        t -= self[ii][jj - wk] if jj - wk >= 0
        t -= self[ii - hk][jj] if ii - hk >= 0
        t += self[ii - hk][jj - wk] if jj - wk >= 0 && ii - hk >= 0
        res[i][j] = t
      end
    end
    res
  end

  def abc203_pond(hk, wk, th)
    h = size
    w = self[0].size
    #hk = wk = k
    raise ArgumentError.new if h < hk || w < wk

    hr = h - hk + 1
    wr = w - wk + 1
    res = Array.new(hr){ [0] * wr }
    (0...hr).each do |i|
      (0...wr).each do |j|
        ii = hk - 1 + i
        jj = wk - 1 + j
        t = self[ii][jj]
        t -= self[ii][jj - wk] if jj - wk >= 0
        t -= self[ii - hk][jj] if ii - hk >= 0
        t += self[ii - hk][jj - wk] if jj - wk >= 0 && ii - hk >= 0
        res[i][j] = t
        return true if th <= t
      end
    end
    false
  end
end

#a = [[1, 0, 1], [1, 1, 0], [1, 0, 1]]
#cs = a.cumsum2d
#p cs.pond(2)

# [[1, 1, 2], [2, 3, 4], [3, 4, 6]]

def abc203d
  n, k = gets.to_s.split.map{ |t| t.to_i }
  a = Array.new(n){ gets.to_s.split.map{ |t| t.to_i } }

  k2m = (k * k) - ((k * k) / 2 + 1) + 1
  ans = a.flatten.sort.bsearch{ |ans|
    m = a.map{ |row| row.map{ |e| e <= ans ? 1 : 0 } }
    m.cumsum2d.abc203_pond(k, k, k2m)
  }

  p ans
end
