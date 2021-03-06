require "spec"

require "../union_find.cr"

describe UnionFind do
  describe "#unite" do
    it "atc001" do
      uf = UnionFind.new(8)
      uf.unite(1, 2)
      uf.unite(3, 2)
      uf.same?(1, 3).should be_true
      uf.same?(1, 4).should be_false
      uf.unite(2, 4)
      uf.same?(4, 1).should be_true
      uf.unite(4, 2)
      uf.unite(0, 0)
      uf.same?(0, 0).should be_true
    end

    it "test" do
      uf = UnionFind.new(3)
      uf.groups.should eq [[0], [1], [2]]
      uf.unite(0, 1)
      uf.groups.should eq [[0, 1], [2]]
    end
  end
end
