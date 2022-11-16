
https://twitter.com/0x3b800001/status/1591683006405935106

class DSU < Hash
  def unite(i, j)
    x = self[i] ||= [i]
    y = self[j] ||= [j]
    return false if x ==y
    x, y = y, x if x.size < y.size
    y.each do |v|
      self[v] = x << v
    end
    true
  end

  def groups
    values.uniq(&:object_id)
  end
end

uf = DSU.new
uf.unite(:x, :y)
uf.unite(:x, :y)
uf.unite(:x, :z)

uf.unite(:a, :b)
