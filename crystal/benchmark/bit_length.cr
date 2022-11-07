struct Int
  def bit_length
    n = self
    res = 0_i64
    while n > 0
      res += 1
      n //= 2
    end
    res.to_i64
  end

  def bit_length2
    n = self
    res = 0
    while n > 0
      res += 1
      n //= 2
    end
    res.to_i64
  end

  def bit_length3
    return 0 if self == 0
    s = to_s(2).size
    if s > 0
      s
    else
      s - 1
    end
  end
end

# p -1.bit_length
# p -1.bit_length2
# p -3.bit_length
# p -3.bit_length2
# p -4.bit_length
# p -4.bit_length2
# p 0.bit_length
# p 0.bit_length2
# p 1023.bit_length
# p 1023.bit_length2
# p 1024.bit_length
# p 1024.bit_length2
# p 1234.bit_length
# p 1234.bit_length2

require "benchmark"
n = 1000_000
x = 1_000_000_000_000_000
rng = (x...x+n)
Benchmark.bm do |r|
  r.report("bit_length "){ n.times{ |i| i.bit_length } }
  r.report("bit_length2"){ n.times{ |i| i.bit_length2 } }
  # r.report("bit_length3"){ n.times{ |i| i.bit_length3 } } # Slower

  r.report("bit_length "){ rng.each{ |i| i.bit_length } }
  r.report("bit_length2"){ rng.each{ |i| i.bit_length2 } }
  # r.report("bit_length3"){ rng.each{ |i| i.bit_length3 } } # Slower
end

# $ crystal run crystal/benchmark/bit_length.cr --release
# to_sを使ったbit_length3は、2(~8)倍ぐらい遅いな。
