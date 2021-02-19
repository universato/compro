require "spec"

require "../macro.cr"

describe "macro" do
  it "chmax" do
    a = 0
    chmax(a, 5)
    a.should eq 5
    chmax(a, 1 << 1)
    chmax(a, 2)
    a.should eq 5
    chmax(a, 3)
    a.should eq 5
    chmax(a, 10)
    chmax(a, 10 + 0)
    a.should eq 10

    a = 0
    b = 1
    chmax(b, a)
    a.should eq 0
    b.should eq 1

    chmax(a, b)
    a.should eq 1
    b.should eq 1
  end

  it "chmin" do
    a = 5
    chmin(a, 10)
    a.should eq 5
    chmin(a, 2)
    a.should eq 2
    chmin(a, 3)
    a.should eq 2
    chmin(a, 10)
    chmin(a, 10 + 0)
    chmin(a, 0 + 10)
    chmin(a, 3 << 2)
    chmin(a, 1 << 5)
    a.should eq 2

    a = 1
    b = 0
    chmin(b, a)
    a.should eq 1
    b.should eq 0

    chmin(a, b)
    a.should eq 0
    b.should eq 0
  end
end
