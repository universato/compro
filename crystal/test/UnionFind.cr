require "spec"

require "../UnionFind.cr"

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

    it "test out of range" do
      uf = UnionFind.new(10)
      expect_raises(ArgumentError){ uf.root(10) }
    end

    it "test out of range" do
      uf = UnionFind.new(8)
      expect_raises(ArgumentError){ uf.unite(8, 1) }
    end

    it "test out of range" do
      uf = UnionFind.new(8)
      expect_raises(ArgumentError){ uf.same?(0, 100) }
    end
  end
end
