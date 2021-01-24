def compress(x1, x2, w)
  n = x1.size
  xs = []
  n.times do |i|
    (-1..1).each do |d| # (0..0)にすると完全な座標圧縮
      tx1 = x1[i] + d
      tx2 = x2[i] + d
      xs.push(tx1) if 1 <= tx1 && tx1 <= w
      xs.push(tx2) if 1 <= tx2 && tx2 <= w
    end
  end
  xs.sort!.uniq!
  n.times do |i|
    x1[i] = xs.find_index(x1[i]) || xs.size
    x2[i] = xs.find_index(x2[i]) || xs.size
  end

  xs.size
end

def solve_arihon
  w, h, n = 10, 10, 5
  x1 = [1, 1, 4, 9, 10]
  x2 = [6, 10, 4, 9, 10]
  y1 = [4, 8, 1, 1, 6]
  y2 = [4, 8, 10, 5, 10]

  w = compress(x1, x2, w)
  h = compress(y1, y2, h)

  n6 = n * 6 # 古い蟻本はn * 3となっているが、誤植らしい。
  fld = Array.new(n6){ [nil] * n6 }
  n.times do |i|
    xs, xe, ys, ye = x1[i], x2[i], y1[i], y2[i]
    (ys..ye).each do |y|
      (xs..xe).each do |x|
        fld[y][x] = true
      end
    end
  end

  dxy = [[1, 0], [-1, 0], [0, 1], [0, -1]]

  ans = 0
  h.times do |y|
    w.times do |x|
      next if fld[y][x]

      ans += 1

      que = []
      que.push([x, y])
      while (sx, sy = que.shift)
        dxy.each do |dx, dy|
          tx = sx + dx
          ty = sy + dy
          next if tx < 0 || w <= tx || ty < 0 || h <= ty
          next if fld[ty][tx]

          que.push([tx, ty])
          fld[ty][tx] = true
        end
      end
    end
  end

  puts ans
end

# solve_arihon

# 蟻本の正誤表サポートページ
# https://book.mynavi.jp/support/pc/pcontest/
