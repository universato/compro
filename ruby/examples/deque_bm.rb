require 'benchmark'



def queries(d, i)
  d.reverse!
  d.push(i)
  d.reverse!
  d.pop
  d.push(i)
end

require "benchmark"
n = 10**4
m = 10**5
a = [0] * m
Benchmark.bm do |r|
  require_relative '../deque.rb'
  # require_relative '../deque_reversible.rb'
  r.report{
    d = Deque[]
    n.times{ |i|
      queries(d, i)
    }
    # p d.to_a[0, 10]
  }

  require_relative '../deque.rb'
  # require_relative '../deque_reversible.rb'
  r.report{
    d = Deque[]
    n.times{| i|
      queries(d, i)
    }
    # p d.to_a[0, 10]
  }
end
