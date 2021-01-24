# Diameter of a Tree
# http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_5_A&lang=ja
# https://onlinejudge.u-aizu.ac.jp/courses/library/5/GRL/5/GRL_5_A

# 2回BFSをして、木の距離を求める。
# 1回目のBSFは、ある1点からの全ての距離。
# 1回目で求めたある点から最も離れた点から再びBFSをする。
# 経路復元のときは、DFSじゃないと厳しいかな。
# BFS部分でn + 1の配列のサイズにしているのは、0 based indexでも1 based indexでも動けるようにだっけ。

class Tree
  class << self
    def get(n = nil)
      n ||= gets.to_s.to_i
      tree = Tree.new(n)
      (n - 1).times do
        s, t, w = gets.to_s.split.map{ |t| t.to_i }
        tree.g[s] << [t, w]
        tree.g[t] << [s, w]
      end
      tree
    end
  end

  def initialize(n)
    @g = Array.new(n){ [] }
  end
  attr_reader :g

  def diameter(s = 0)
    max_node, max_len = bfs(s)
    max_node, max_len = bfs(max_node)
    max_len
  end

  private def bfs(s = 0)
    n = @g.size
    d = Array.new(n + 1)
    d[s] = 0
    que = [s]

    max_node = s
    max_len = 0
    while (v = que.shift)
      cost = d[v]
      @g[v].each do |(u, edge_cost)|
        next if d[u]

        d[u] = tmp_len = cost + edge_cost
        max_len, max_node = tmp_len, u if max_len < tmp_len
        que.push(u)
      end
    end
    [max_node, max_len]
  end
end

puts Tree.get.diameter

# 非公開のはず。
# https://onlinejudge.u-aizu.ac.jp/status/users/universato/submissions/1/GRL_5_A/judge/5149724/Ruby
# https://onlinejudge.u-aizu.ac.jp/status/users/universato/submissions/1/GRL_5_A/judge/5149779/Ruby
# https://onlinejudge.u-aizu.ac.jp/status/users/universato/submissions/1/GRL_5_A/judge/5149801/Ruby
