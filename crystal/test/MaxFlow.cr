require "spec"
require "../MaxFlow.cr"

describe MaxFlow do
  describe "maxflow" do
    it "" do
      g = MaxFlow.new(4)
      g.add_edge(0, 1, 1i64).should eq 0
      g.add_edge(0, 2, 1i64).should eq 1
      g.add_edge(1, 3, 1i64).should eq 2
      g.add_edge(2, 3, 1i64).should eq 3
      g.add_edge(1, 2, 1i64).should eq 4
      g.flow(0, 3).should eq 2

      edges = [
        [0, 1, 1, 1],
        [0, 2, 1, 1],
        [1, 3, 1, 1],
        [2, 3, 1, 1],
        [1, 2, 1, 0],
      ]
      edges.each_with_index do |edge, i|
        g.get_edge(i).should eq edge
      end
      g.edges.should eq edges
      g.min_cut(0).should eq Deque{true, false, false, false}
    end
    it "arihon" do
      g = MaxFlow.new(5)
      edges = [{0, 1, 10}, {0, 2, 2}, {1, 2, 6}, {1, 3, 6}, {2, 4, 5}, {3, 2, 3}, {3, 4, 8}]
      edges.each{ |(i, j, c)| g.add_edge(i, j, c.to_i64) }
      g.flow(0, 4).should eq 11
    end
  end
end
