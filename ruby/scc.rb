class SCC
  def initialize(n = 0)

  end

  def add_edge(from, to)
    raise ArgumentError.new unless 0 <= from && from <= @n
    raise ArgumentError.new unless 0 <= to && to <= @n
    _add_edge(from, to)
  end

  private _add_edge(from, to)
    @edges.push(from, to)
  end

  def scc_ids
    now_ord = 0
    group_num = 0
    visited
  end
end

# https://github.com/atcoder/ac-library/blob/master/atcoder/internal_scc.hpp
