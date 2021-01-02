# ABC132 Blue and Red Balls 2020/5/13 hom  nHk
# ABC145 2020/5/6
# ABC156 Roaming 2020/5/11 AC cmb
# ABC167 E - Colorful Blocks 2020/5/11 AC

def abc156
  # ABC156 Roaming 2020/5/11 AC

  mod = 10**9 + 7

  n, k = gets.to_s.split.map{ t| t.to_i }

  ans = 0
  f = Facts.new

  if n <= k
    puts f.hom(n, n)
    puts "a"
    exit
  end

  0.upto([n-1, k].min) do |i|
    ans += f.cmb(n, i) * f.hom(n-i, i)
    ans %= mod if ans >= mod
  end

  puts ans
end
