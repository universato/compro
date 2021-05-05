# The MIT License (MIT)

# Copyright (c) 2017 [Athitya Kumar](https://github.com/athityakumar/).

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module NetworkX
  class UnionFind
    def initialize(nodes)
      @unions = {}
      nodes.each_with_index do |node, index|
        @unions[node] = index
      end
    end

    def connected?(node_1, node_2)
      @unions[node_1] == @unions[node_2]
    end

    def union(node_1, node_2)
      return if connected?(node_1, node_2)

      node1_id = @unions[node_1]
      node2_id = @unions[node_2]

      @unions.each do |node, id|
        @unions[node] = node1_id if id == node2_id
      end
    end
  end
end

# ____________________________________________________________________
#
# ____________________________________________________________________

def atc001
  n, q = gets.to_s.split.map{ |e| e.to_i }
  uf = NetworkX::UnionFind.new((0...n).to_a)
  q.times do
    query, a, b = gets.to_s.split.map{ |e| e.to_i }
    if query == 0
      uf.union(a, b)
    else
      puts uf.connected?(a, b) ? "Yes" : "No"
    end
  end
end

atc001
