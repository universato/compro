# Qiita: Crystalで競プロをする際のテクニックまとめ
# https://qiita.com/hakatashi/items/0892366ea47f1e88083d

require "benchmark"

def max1(a, b)
  [a, b].max
end

def max5(a, b)
  a > b ? a : b
end

def max4(a, b)
  {a, b}.max
end


# macro max4(a, b)
#   [{{a}}, {{b}}].max
# end

macro max2(a, b)
  {{a}} > {{b}} ? {{a}} : {{b}}
end

macro max3(a, b)
  { {{a}}, {{b}} }.max
end

n = 10**3
Benchmark.ips do |x|
  x.report("Array#max") {
    n.times{
    max1(10, 100)
    max1(-10, 100)
    max1(10003, 10002)
    max1(22222, 111111)
    max1(33, 4)
    max1(3003, -3003)
    max1(0, 0)
    max1(100, 20)
    max1(Int32::MIN, Int32::MAX)
    max1(16, 1)
}
  }
  x.report("2: Ternary operator") {
    n.times{
    max2(10, 100)
    max2(-10, 100)
    max2(10003, 10002)
    max2(22222, 111111)
    max2(33, 4)
    max2(3003, -3003)
    max2(0, 0)
    max2(100, 20)
    max2(Int32::MIN, Int32::MAX)
    max2(16, 1)}
  }
  x.report("3: Tupple") {
    n.times{
    max3(10, 100)
    max3(-10, 100)
    max3(10003, 10002)
    max3(22222, 111111)
    max3(33, 4)
    max3(3003, -3003)
    max3(0, 0)
    max3(100, 20)
    max3(Int32::MIN, Int32::MAX)
    max3(16, 1)}
  }
  x.report("4: Tupple") {
    n.times{
    max4(10, 100)
    max4(-10, 100)
    max4(10003, 10002)
    max4(22222, 111111)
    max4(33, 4)
    max4(3003, -3003)
    max4(0, 0)
    max4(100, 20)
    max4(Int32::MIN, Int32::MAX)
    max4(16, 1)}
  }
  x.report("5: macro if") {
    n.times{
    max5(10, 100)
    max5(-10, 100)
    max5(10003, 10002)
    max5(22222, 111111)
    max5(33, 4)
    max5(3003, -3003)
    max5(0, 0)
    max5(100, 20)
    max5(Int32::MIN, Int32::MAX)
    max5(16, 1)}
  }
end
