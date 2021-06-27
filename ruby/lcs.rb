class LCS
  def initialize(s, t)
    @type = s.class
    if s.is_a?(String)
      s = s.codepoints
      t = t.codepoints
    end

    if s.size > t.size
      @swap = true
      s, t = t, s
    end
    @s = s
    @t = t
  end

  def lcs
    dp = @dp || _dp
    sub = []
    i = @s.size
    j = @t.size
    while 0 < i
      if dp[i-1][j] == dp[i][j]
        i -= 1
      elsif dp[i][j-1] == dp[i][j]
        j -= 1
      else
        sub.unshift(@s[i-1])
        i -= 1
        j -= 1
      end
    end
    sub.pack('c*')
  end

  def dp
    dp = @dp || _dp
  end

  private def _dp
    s, t = @s, @t
    n = s.size
    m = t.size

    dp = Array.new(n + 1){ [0] * (m + 1) }
    n.times do |i|
      dpi = dp[i]
      dpi1 = dp[i + 1]
      m.times do |j|
        if s[i] == t[j]
          dpi1[j + 1] = dpi[j] + 1
        else
          dpi1[j+1] = dpi1[j] > dpi[j + 1] ? dpi1[j] : dpi[j + 1]
        end
      end
    end

    @dp = dp
  end
end

s = gets.to_s.chomp
t = gets.to_s.chomp

lcs = LCS.new(s, t)
puts lcs.lcs
