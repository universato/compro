macro chmax(x, y)
  {{x}} = {{y}} if {{x}} < {{y}}
end

require "benchmark"

n = 10_000_000
Benchmark.bm do |r|
  x = 0
  r.report("{}.max"){ n.times{ |y| x = {x, y}.max } }

  x = 0
  r.report("chmax "){ n.times{ |y| chmax(x, y) } }
end

# chmaxの方が桁違いに速い。
