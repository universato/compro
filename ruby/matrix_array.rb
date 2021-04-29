class Array
  def clock90
    transpose.map(&:reverse)
  end

  def clock180
    reverse.map(&:reverse)
  end

  def clock270
    transpose.reverse
  end
end

Array

# [rubyで2次元配列を使用しての行列表現＆行列の回転 \- simanのブログ](https://simanman.hatenablog.com/entry/2013/03/27/014011)


class Array
  def matrix_product(other)
    factor = other.size
    col = other[0].size
    (0...size).map do |i|
      (0...col).map do |j|
        s = 0
        k = 0
        while k < factor
          s = (s + self[i][k] * other[k][j])
          k += 1
        end
        s
      end
    end
  end

  def mod_matrix_product(other)
    factor = other.size
    col = other[0].size
    (0...size).map do |i|
      (0...col).map do |j|
        s = 0
        k = 0
        while k < factor
          s = (s + self[i][k] * other[k][j]) % mod
          k += 1
        end
        s
      end
    end
  end
end

a = [[1, 2], [3, 4]]
e = [[1, 0], [0, 1]]
b = [[5, 6], [7, 8]]

p a.matrix_product(b)  # => [[19, 22], [43, 50]]
p e.matrix_product(a)  # => [[1, 2], [3, 4]]
p a.matrix_product(e)  # => [[1, 2], [3, 4]]
p [[1, 2, 3]].matrix_product([[1], [2], [3]])  # => [[14]]
