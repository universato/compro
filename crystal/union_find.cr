struct UnionFind

  #attr_accessor :parents
  getter parents
  @parents : Array(Int32)
  @rank: Array(Int32)

  def initialize(size)
    @rank = Array(Int32).new(size, 0)
    @parents = Array(Int32).new(size, &.to_i32)
  end

  def unite(a, b)
    a = root(a)
    b = root(b)
    return if a == b
    #a,b = b,a if (-@parents[a] < -@parents[b])
    #@parents[a] += @parents[b]
    @rank[b] += 1 if @rank[a] == @rank[b]
    @parents[b] = a
  end

  def root(a)
    while a != @parents[a]
        a = @parents[a] = @parents[@parents[a]]
       #if @parents[par] < 0
        # @parents[a] = par
       #end
       #a = par
    end
    a
  end

  def same?(a, b)
    root(a) == root(b)
  end

  def size(a)
    -@parents[a]
  end
end

n,q=gets.to_s.split.map{|i|i.to_i}
uft=UnionFind.new(n+1)

q.times do
  qu,a,b=gets.to_s.split.map{|i|i.to_i}
  if qu==0
    uft.unite(a,b)
    #p uft.parents
  else
    puts uft.root(a) == uft.root(b) ? "Yes" : "No"
  end
end
