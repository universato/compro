# class String
#   def /(x)
#     "aaaa"
#   end
# end

# struct Range
#   def /(x)
#     "aaaa"
#   end
# end

require "benchmark"
n = 10**6

x = 1_000_000_000_000_000
x = 1_000_000_000_000_000i128
x = 10**9
y = 1e9
z = 1e9
p! x == y # true
p! pointerof(x) # => Pointer((Float64 | Int128 | Int32 | Int64 | String))@0x1003a6fc8
p! pointerof(y) # => Pointer(Float64)@0x1003a6fe0
Benchmark.bm do |r|
  # r.report("float"){ n.times{ y /= 1.01  } }
  # r.report("union"){ n.times{ x /= 1.01  } }
  r.report("float"){ n.times{ z /= 1.01  } }
end

p x
p y
p x.class
p y.class
# p 7.5 / 5.9
# p 5.03 / 4.4
# p 6.34 / 4.4
# p 5.4 / 4.4
# p 7.0 / 4.0
