def compress(a)
  a = a.sort
  h = {}
  a.each{ |e| h[e] || h[e] = h.size }
  h.keys
  h
end

a = [1, 10, 12, 13, 14, 56, 5, 6]
p compress(a)
# => {1=>0, 5=>1, 6=>2, 10=>3, 12=>4, 13=>5, 14=>6, 56=>7}
