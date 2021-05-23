def compress(a)
  a = a.sort
  h = {}
  a.each{ |e| h[e] || h[e] = h.size }
  h.keys
  h
end

def compress!(a)
  s = a.sort
  h = {}
  s.each{ |e| h[e] || h[e] = h.size }
  h.keys
  a.map!{ |e| h[e] }
  h
end

b = [10, 6, 8, 10, 8, 6]
p compress!(b)
p b

# 第2回日本学生コンテスト? F問題
def compress1(a)
  s = a.sort
  h = {0 => 0}
  s.each{ |e| h[e] || h[e] = h.size }
  a.replace a.map{ |e| h[e] }
  h.keys
end

a = [1, 10, 12, 13, 14, 56, 5, 6]
a = [10, 20, 5, 30]
# p compress(a)
# => {1=>0, 5=>1, 6=>2, 10=>3, 12=>4, 13=>5, 14=>6, 56=>7}

a = [10, 20, 5, 30]
p compress1(a) # => [0, 5, 10, 20, 30]
p a            # => [2, 3, 1, 4]

__END__

`10 20 5 30`
破壊的変更`2 3 1 4 `

返り値`0 5 10 20 30`
