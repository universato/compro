class Array
  def abs; map{|k| k.abs } end
  def cumgcd; res = self[0]; map{|t| res = t.gcd(res) } end
  def cummax; res = self[0]; map{|t| res > t ? res : (res = t) } end
  def cumsum; s = 0; map{|k| s += k } end
  def deru_kui(m); map{|t| t>m ? m : t } end
  def diff; (size-1).times.map { |i| self[i + 1] - self[i] }.to_a end
  def soko_age(m); map{|t| t<m ? m : t } end
end

require "spec"

describe Array do
  describe "#abs" do
    it "is absolute numbers of integers" do
      Array(Int32).new.abs.should eq [] of Int32
      [1,-2,3].abs.should eq [1,2,3]
    end
  end
  describe "#cumgcd" do
    it "is cumulative gcd" do
      #Array(Int32).new.cumgcd.should eq [] of Int32
      [2,3,6].cumgcd.should eq [2,1,1]
      [12,3,4].cumgcd.should eq [12,3,1]
      [24,36,4].cumgcd.should eq [24,12,4]
    end
  end
  describe "#cummax" do
    it "is cumulative max" do
      #Array(Int32).new.cummax.should eq [] of Int32
      [2,3,6].cummax.should eq [2,3,6]
      [12,3,4].cummax.should eq [12,12,12]
      [24,36,4].cummax.should eq [24,36,36]
    end
  end
  describe "#cumsum" do
    it "is cumulaive sum" do
      Array(Int32).new.cumsum.should eq [] of Int32
      [2,3,6].cumsum.should eq [2,5,11]
      [12,3,4].cumsum.should eq [12,15,19]
      [24,36,4].cumsum.should eq [24,60,64]
    end
  end
  describe "#deru_kui" do
    it "is that deru_kui wa utareru" do
      Array(Int32).new.deru_kui(10).should eq [] of Int32
      [2,3,6].deru_kui(3).should eq [2,3,3]
      [12,3,4].deru_kui(4).should eq [4,3,4]
      [24,36,4].deru_kui(5).should eq [5,5,4]
    end
  end
  describe "#diff" do
    it "is difference between adjective elements" do
      #Array(Int32).new.diff.should eq [] of Int32
      [0].diff.should eq [] of Int32
      [120].diff.should eq [] of Int32
      [9876543210].diff.should eq [] of Int64
      [2,3,6].diff.should eq [1,3]
      [12,3,4].diff.should eq [-9,1]
      [24,36,4].diff.should eq [12,-32]
    end
  end
  describe "#soko_age" do
    it "is that soko_age wa utareru" do
      Array(Int32).new.soko_age(10).should eq [] of Int32
      [2,3,6].soko_age(3).should eq [3,3,6]
      [12,3,4].soko_age(4).should eq [12,4,4]
      [24,36,4].soko_age(5).should eq [24,36,5]
    end
  end
end
