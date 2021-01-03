require "spec"

require "../fenwick_tree.cr"

describe FenwickTree do
  describe "#" do
    it "alpc" do
      a = [1, 2, 3, 4, 5].map{ |e| e.to_i64 }
      fw = FenwickTree(Int64).new(a)
      fw.sum(0, 5).should eq 15
      fw.sum(2, 4).should eq 7
      fw.add(3, 10)
      fw.sum(0, 5).should eq 25
      fw.sum(0, 3).should eq 6
    end

    it "alpc" do
      a = [1, 2, 3, 4, 5].map{ |e| e.to_i64 }
      fw = FenwickTree(Int64).new(a.size)
      a.each_with_index{ |k, i| fw.add(i, k) }
      fw.sum(0, 5).should eq 15
      fw.sum(2, 4).should eq 7
      fw.add(3, 10)
      fw.sum(0, 5).should eq 25
      fw.sum(0, 3).should eq 6
    end
  end
end
