# bundle exec ruby ruby/examples/ac-library-rb/dsu-exap

require 'ac-library-rb/dsu'

d = AcLibraryRb::DSU.new(5)

include AcLibraryRb
d = DSU.new(5)

p d.groups      # => [[0], [1], [2], [3], [4]]
p d.same?(2, 3) # => false
p d.size(2)     # => 1

d.merge(2, 3)
p d.groups      # => [[0], [1], [2, 3], [4]]
p d.same?(2, 3) # => true
p d.size(2)     # => 2

d.merge(0, 2)
p d.groups      # => [[0, 2, 3], [1], [4]]
p d.same?(2, 0) # => true
p d.size(2)     # => 3

p d.leader(0)  # => 2
p d.leader(1)  # => 1
p d.leader(2)  # => 2
p d.leader(3)  # => 2
p d.leader(4)  # => 4



d = DSU.new(5)
# @parent_or_size=[-1, -1, -1, -1, -1]
