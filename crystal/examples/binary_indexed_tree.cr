def poj3468
  #POJ 3468
  n, q = gets.to_s.split.map{|t| t.to_i }
  a    = [0] + gets.to_s.split.map{|t| t.to_i }

  b0 = BinaryIndexedTree.new(n)
  b1 = BinaryIndexedTree.new(n)

  1.upto(n) do |i|
    b0.add(i, a[i])
  end

  q.times do |i|

    tmp = gets.to_s.split
    if tmp[0] == "C"
      l, r, x = tmp[1,3].map{|t|t.to_i}
      b0.add( l,     -x * (l - 1) )
      b1.add( l,      x           )
      b0.add( r + 1,  x * r       )
      b1.add( r + 1, -x           )
    else
      l, r = tmp[1,2].map{|t|t.to_i}
      ans = 0
      ans += b0.sum(r) + b1.sum(r) * r
      ans -= b0.sum(l-1) + b1.sum(l-1) * (l-1)
      puts ans
    end
  end
end
