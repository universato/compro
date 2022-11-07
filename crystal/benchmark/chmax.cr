macro chmax(x, y)
  {{x}} = {{y}} if {{x}} < {{y}}
end

require "benchmark"

n = 10**7
a = Array.new(n){ rand(n) }
m = a.max
Benchmark.bm do |r|
  x = 0
  r.report("chmax "){ a.each{ |k| chmax(x, k) }; raise "!" if x != m }

  x = 0
  r.report("{}.max"){ a.each{ |k| x = {x, k}.max }; raise "!" if x != m }

  x = 0
  r.report("if    "){ a.each{ |k| x = k if x < k }; raise "!" if x != m }
end

# $ crystal run crystal/benchmark/chmax.cr --release
# chmaxの方が桁違いに速い。いや、ちゃんと--releaseつけたら、そんなことないな。
# chmaxとifが同じぐらいかな。{}は、気持ち少し遅いかも。v 1.4.1
