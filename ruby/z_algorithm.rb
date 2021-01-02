class String
  def z_algorithm
    s = codepoints

    n = size
    c = 0
    z = [0] * n
    (1 ... n).each do |i|
      l = i - c # i > c <=> l > 0
      if l < z[c] - z[l]
        # 一致してる範囲内にあるとき
        # i + z[l] < c + z[c]
        # p "z[i] = #{z[l]} if #{i} + #{z[l]} < #{c} + #{z[c]}"
        z[i] = z[l] # z[i] = 0 だと通らないときがある。
        # p z[i]
      else
        # "aaaaaa"みたいなのは主にこっち
        # ここで
        j = [0, z[c] - l].max
        # p j
        # 上の判定式も、c + z[c] - iになるな。# jは最終的にいくつ一致してるかの個数
        j += 1 while i + j < n && s[j] == s[i + j] # 一致してるだけすすめる
        z[i] = j # 一致してた数
        c = i # 一致してた場所
      end
      # p z
    end
    z[0] = n
    z
  end
end

class Array
  def z_algorithm
    n = size
    c = 0
    z = [0] * n
    (1 ... n).each do |i|
      l = i - c
      if l < z[c] - z[l]
        z[i] = z[l]
      else
        j = [0, z[c] - l].max
        j += 1 while i + j < n && self[j] == self[i + j]
        z[i] = j
        c = i
      end
    end
    z[0] = n
    z
  end
end

def xxx
  n = gets.to_s.to_i
  s = gets.to_s.chomp

  ans = 0
  (n - 1).times do |i|
    lcp = s[i, n - i].z_algorithm
    lcp.size.times do |j|
      l = [lcp[j], j].min
      ans = l if ans < l
    end
  end
end

class String
  # naive_algorithm for test
  # テスト用の愚直なアルゴリズム
  def naive_z_algorithm
    n = size
    g = [0] * n
    n.times do |i|
      t = 0
      j = i + t
      while j < n && self[t] == self[j]
        t += 1
        j += 1
      end
      g[i] = t
    end
    g[0] = n
    g
  end
end

require 'minitest'
require 'minitest/autorun'

# Z-algorithm
class ZAlgorithmTest < Minitest::Test
  def test_z_algotirhm
    assert_equal [15, 0, 0, 2, 0, 0, 2, 0, 1, 6, 0, 0, 2, 0, 0], "ATGATCATAATGATC".z_algorithm
    assert_equal [3, 2, 1], "aaa".z_algorithm
    assert_equal [4, 2, 1, 0], "aaad".z_algorithm
    assert_equal [*1..10].reverse, ("a" * 10).z_algorithm
    assert_equal [9, 0, 0, 2, 0, 3, 0, 0, 0], "abcababcx".z_algorithm
    assert_equal [9, 0, 0, 2, 0, 4, 0, 0, 1], "abcababca".z_algorithm
    assert_equal [11, 0, 0, 4, 0, 0, 1, 0, 0, 1, 0], "ississippim".z_algorithm
  end

  def test_z_algotirhm_of_array
    strings = ["ATGATCATAATGATC", "aaa", "aaad", "a" * 10, "abcababcx", "abcababca", "ississippim"]
    strings.each{ |s| assert_equal s.naive_z_algorithm, s.chars.z_algorithm }
  end

  def test_g_algotirhm
    strings = ["ATGATCATAATGATC", "aaa", "aaad", "a" * 10, "abcababcx", "abcababca", "ississippim"]
    strings.each{ |s| assert_equal s.naive_z_algorithm, s.z_algorithm }
  end
end
