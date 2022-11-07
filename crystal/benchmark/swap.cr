macro swap(x, y); t = x; x = y; y = t end

require "benchmark"

n = 10_000_000
x, y = 1, 2
Benchmark.bm do |r|
  r.report("macro swap"){ n.times{ swap(x, y)  } }
  r.report("swap      "){ n.times{ x, y = y, x } }
end

# macro swapの方がちょっと速い。
# そんなこともないな。同じぐらいかな。Crystal 1.4.1
# crystal run swap.cr --release

# Crystal: v1.6.1
# crystal run crystal/benchmark/swap.cr --release
#                  user     system      total        real
# macro swap   0.009806   0.000016   0.009822 (  0.009860)
# swap         0.009815   0.000031   0.009846 (  0.010016)
