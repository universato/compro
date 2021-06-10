# Strongly Connected Components
class SCC
  # initialize graph with n vertices
  def initialize(n = 0)
    @n = n
    @edges = []
  end

  # add directed edge
  def add_edge(from, to)
    raise "invalid params" unless (0...@n).include? from and (0...@n).include? to

    @edges << [from, to]
    self
  end

  # returns list of strongly connected components
  # the components are sorted in topological order
  # O(@n + @edges.size)
  def scc
    group_num, ids = scc_ids
    groups = Array.new(group_num) { [] }
    ids.each_with_index { |id, i| groups[id] << i }
    groups
  end

  private

  def scc_ids
    start, elist = csr
    now_ord = group_num = 0
    visited, low, ord, ids = [], [], [-1] * @n, []
    dfs = ->(v) {
      low[v] = ord[v] = now_ord
      now_ord += 1
      visited << v
      (start[v]...start[v + 1]).each do |i|
        to = elist[i]
        low[v] = if ord[to] == -1
                   dfs.(to)
                   [low[v], low[to]].min
                 else
                   [low[v], ord[to]].min
                 end
      end
      if low[v] == ord[v]
        loop do
          u = visited.pop
          ord[u] = @n
          ids[u] = group_num
          break if u == v
        end
        group_num += 1
      end
    }
    @n.times { |i| dfs.(i) if ord[i] == -1 }
    ids = ids.map { |x| group_num - 1 - x }
    [group_num, ids]
  end

  def csr
    start = [0] * (@n + 1)
    elist = [nil] * @edges.size
    @edges.each { |(i, _)| start[i + 1] += 1 }
    @n.times { |i| start[i + 1] += start[i] }
    counter = start.dup
    @edges.each do |(i, j)|
      elist[counter[i]] = j
      counter[i] += 1
    end
    [start, elist]
  end
end

# class alias
StronglyConnectedComponents = SCC
SCCGraph = SCC
SCCG = SCC

# template <class E> struct csr {
#   std::vector<int> start;
#   std::vector<E> elist;
#   explicit csr(int n, const std::vector<std::pair<int, E>>& edges)
#       : start(n + 1), elist(edges.size()) {
#       for (auto e : edges) {
#           start[e.first + 1]++;
#       }
#       for (int i = 1; i <= n; i++) {
#           start[i] += start[i - 1];
#       }
#       auto counter = start;
#       for (auto e : edges) {
#           elist[counter[e.first]++] = e.second;
#       }
#   }
# };
