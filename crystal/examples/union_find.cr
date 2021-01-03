require "../union_find_light.cr"

def atc001
  # https://atcoder.jp/contests/atc001/submissions/19176662
  n, q = gets.to_s.split.map{ |e| e.to_i }
  uf = UnionFind.new(n)
  q.times do
    query, a, b = gets.to_s.split.map{ |e| e.to_i }
    if query == 0
      uf.unite(a, b)
    else
      puts uf.same?(a, b) ? "Yes" : "No"
    end
  end
end
