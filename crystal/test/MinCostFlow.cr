require "spec"
require "../MinCostFlow.cr"

describe MinCostFlow do
  describe "mincostflow" do
    it "simple" do
    g = MinCostFlow.new(4)
    g.add_edge(0, 1, 1, 1i64)
    g.add_edge(0, 2, 1, 1i64)
    g.add_edge(1, 3, 1, 1i64)
    g.add_edge(2, 3, 1, 1i64)
    g.add_edge(1, 2, 1, 1i64)

    g.slope(0, 3, 10).should eq [[0, 0], [2, 4]]

    edges = [
      [0, 1, 1, 1, 1],
      [0, 2, 1, 1, 1],
      [1, 3, 1, 1, 1],
      [2, 3, 1, 1, 1],
      [1, 2, 1, 0, 1],
    ]
    #edges.each_with_index { |edge, i| g.get_edge(i).should eq edge }
    #g.edges.should eq edges
    end
  end
end
