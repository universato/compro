## うまくいってない

class RollingHash
  @@base1 = 1007
  @@base2 = 2009
  @@mod1 = 10 ** 9 + 7
  @@mod2 = 10 ** 9 + 9

  def initialize(s)
    n = s.size
    s = s.bytes
    @hash1 = [0] * (n+1)
    @hash2 = [0] * (n+1)
    @power1 = [1] * (n+1)
    @power2 = [1] * (n+1)
    n.times do |i|
      @hash1[i+1] = (@hash1[i] * @@base1 + s[i]) % @@mod1
      @hash2[i+1] = (@hash2[i] * @@base2 + s[i]) % @@mod2
      @power1[i+1] = (@power1[i] * @@base1) % @@mod1;
      @power2[i+1] = (@power2[i] * @@base2) % @@mod2;
    end
    # p s.size
    # p @hash1.size
    # p @hash1
    # p @power1
  end

  def get(l, r)
    res1 = (@hash1[r] - @hash1[l] * @power1[r-l] ) % @@mod1;
    res2 = (@hash2[r] - @hash2[l] * @power2[r-l] ) % @@mod2;
    [res1, res2]
  end

  def get_lcp(a, b)
    len = [@hash1.size - a, @hash1.size - b].min
    res = (0 .. len).bsearch{ |t| get(a, a+t) >= get(b, b+t) }
    res
  end
end

class Array
  include Comparable
end

n = gets.to_s.to_i
s = gets.to_s.chomp

rh = RollingHash.new(s)

ans = ( 0 ... (n/2 + 1)).bsearch do |x|
  h = {}
  flag = true
  0.upto(n-x) do |i|
    q = rh.get(i, i+x)
    if h[q] && i - h[q] >= x
      # p [x, i, h[q]]
      flag = false
      false
      break
    else
      h[q] = i
    end
  end
  flag ? true : false
end

p ans - 1
p "=====ans====="

s = RollingHash.new("abcabcsnf")

p s.get(0, 2)
p s.get(3, 5)
p s.get(1, 2)
p s.get(4, 5)

p s.get_lcp(0, 2)
