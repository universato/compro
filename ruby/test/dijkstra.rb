require_relative '../dijkstra.rb'

require 'minitest'
require 'minitest/autorun'

# Dijkstra
class DijkstraTest < Minitest::Test
  def test_grl1a_sample1
    v = 4
    g = Array.new(v){ [] }

    edges = [[0, 1, 1], [0, 2, 4], [1, 2, 2], [2, 3, 1], [1, 3, 5]]
    edges.each do |s, t, c|
      g[s] << Node.new(t, c)
    end

    assert_equal [0, 1, 3, 4], dijkstra(g, 0)
  end

  def test_grl1a_sample2
    v = 4
    g = Array.new(v){ [] }

    edges = [[0, 1, 1], [0, 2, 4], [2, 0, 1], [1, 2, 2], [3, 1, 1], [3, 3, 5]]
    edges.each do |s, t, c|
      g[s] << Node.new(t, c)
    end
    assert_equal [3, 0, 2, "INF"], dijkstra(g, 1)
  end
end
