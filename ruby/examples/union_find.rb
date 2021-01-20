require_relative '../union_find.rb'

def atc001
  # https://atc001.contest.atcoder.jp/tasks/unionfind_a

  n, q = gets.split.map{ |e | e.to_i }
  tr = UnionFind.new(n + 1)

  q.times do
    qu, a, b = gets.split.map &:to_i
    if qu == 0
      tr.unite(a, b)
    else
      puts tr.root(a) == tr.root(b) ? "Yes" : "No"
    end
  end
end

uf = UnionFind.new(5)
uf.unite(3, 4)
uf.root(3)
uf.same?(3, 4)
