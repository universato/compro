# https://ei1333.github.io/luzhiled/snippets/structure/sparse-table.html
# https://github.com/magurofly/shed/blob/master/sparse-table.rb

## sparceではなく、sparse

# 未完
# class SparseTable
#   def initialize(a)
#     b = 0
#     b += 1 while (1 << b) <= v.size
#     @lookup = Array.new(a.size + 1)
#     (2...@lookup.size).each{ |i| @lookup[i] = @lookup[i >> 1] + 1 }
#   end

#   def rmq(l, r)
#     b = @lookup[r - l]
#     [st[b][l], st[b][r - (1 << b)]].min
#   end
# end
