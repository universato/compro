macro swap(x, y); t = x; x = y; y = t end

require "benchmark"

n = 10_000_000
x, y = 1, 2
Benchmark.bm do |r|
  r.report("swap        "){ n.times{ x, y = y, x } }
  r.report("macro swap"){ n.times{ swap(x, y) } }
end
# macro swapの方がちょっと速い。
