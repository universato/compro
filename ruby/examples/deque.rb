require_relative '../deque.rb'
require_relative '../deque_reversible.rb'

p Array.methods - Deque.methods
m = Array.instance_methods - Deque.instance_methods
p m.sort

p Deque[]

d = Deque[1, 2, 3]
p d.clear
p d

# d = Deque[:z, :a, :b, :c]
# p d[1, 2]
# d.shift
# p d[1, 2]
# p d.count{ |e| e >= 2 }

# d1 = Deque[]
# d2 = Deque[1, 2, 3]

# p d1.dig(1, 2, 3)
# p d1.dig(1)
# p d1 + d2

# p d
# d.unshift(1)
# p 'd'
# p d
# d.unshift(0)
# p d
# p d
# d.unshift(nil)
# p d.size
# d.push('a')
# assert_equal 3, d.size
# d.pop
# assert_equal 2, d.size
# d.shift
# assert_equal 1, d.size

# p d = Deque[1, 2, 3]
# p d.size


# d = Deque[1]

# d.shift
# # p d
# d << 0
# p d
# d << 1
# p d
