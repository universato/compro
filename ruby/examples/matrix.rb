require 'benchmark'


def common_matrix(m)
  m + m
  m - m
  m.diagonal?
  m.transpose
  m.det
  m.tr
  m.symmetric?
end

def common_vector(v)

end

n = 10**4

Benchmark.bm(10) do |r|
  require_relative '../matrix'
  r.report("test") do
    m = Matrix.new(1, 2, 3, 4)
    v = Vector.new(1, 2)
    n.times do |i|
      common_matrix(m)
      common_vector(v)
    end
  end

  require 'matrix'
  r.report("test") do
    m = Matrix[[1, 2], [3, 4]]
    v = Vector[1, 2]
    n.times do |i|
      common_matrix(m)
      common_vector(v)
    end
  end
end
