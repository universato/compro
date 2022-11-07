require "benchmark"
n = 5 * 10**4
a = [0] * n
b = [0] * n

Benchmark.bm(13) do |r|
  r.report("pop/push"){
    n.times{
      a.push(1)
      a.pop
    }
  }

  r.report("unshift/shift"){
    n.times{
      b.unshift(1)
      b.shift
    }
  }
end
