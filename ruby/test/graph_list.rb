require_relative "../graph_list.rb"

require 'minitest'
require 'minitest/autorun'

# Dijkstra
class DijkstraTest < Minitest::Test
  def test_grl1a_sample1
    v = 4
    s = 0
    edges = [[0, 1, 1], [0, 2, 4], [1, 2, 2], [2, 3, 1], [1, 3, 5]]

    g = DiGraphList.new(v)
    g.add_edges(edges)
    assert_equal [0, 1, 3, 4], g.dijkstra(s)
  end

  def test_grl1a_sample2
    v = 4
    s = 1
    edges = [[0, 1, 1], [0, 2, 4], [2, 0, 1], [1, 2, 2], [3, 1, 1], [3, 3, 5]]

    g = DiGraphList.new(v)
    g.add_edges(edges)
    assert_equal [3, 0, 2, "INF"], g.dijkstra(s)
  end
end
