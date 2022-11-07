# Refer to: C00 https://github.com/universato/ac-library-rb/blob/main/lib/dsu.rb
# Refer to: https://networkx.org/documentation/stable/_modules/networkx/utils/union_find.html#UnionFind.union
module NetworkX
  # Union Find Tree
  #
  # @attr_reader parents [Hash{ Object => Object }] Return parent of each element
  # @attr_reader weights [Hash{ Object => Integer }] Return weight of each element
  class UnionFind(T)
    property parents : Hash(T, T)
    property weights : Hash(T, Int32)

    # Constructor for initializing Union Find Tree
    #
    # @param nodes [?Array[Object]] nodes
    #
    # @return [UnionFind] Union Find Tree
    def initialize
      @weights = {} of T => Int32
      @parents = {} of T => T
    end

    def initialize(nodes)
      @weights = {} of T => Int32
      @parents = {} of T => T
      nodes.each do |node|
        @weights[node] = 1
        @parents[node] = node
      end
    end

    # Return the root of node
    #
    # @param node [Object] node
    #
    # @return [Object] root of node, leader of node
    def [](node : T) : T
      if @parents.has_key?(node)
        @parents[node] == node ? node : (@parents[node] = self[@parents[node]])
      else
        @weights[node] = 1
        @parents[node] = node
      end
    end

    # Return the root of node
    #
    # @param node [Object] node
    #
    # @return [Object] root of node, leader of node
    def root(node : T) : T
      raise ArgumentError.new("#{node} is not a node") unless parents.has_key?(node)

      @parents[node] == node ? node : (@parents[node] = root(@parents[node]))
    end

    def each(&block)
      @parents.each_key(&block)
    end

    def groups : Array[T]
      (0...@parents.size).group_by { |node| root(node) }.values
    end

    # Is each root of two nodes the same?
    #
    # @param node_1 [Object] node
    # @param node_2 [Object] node
    #
    # @return [bool] Is each root of node_1 and nodes_2 the same?
    def same?(node_1 : T, node_2 : T) : Bool
      root(node_1) == root(node_2)
    end


    macro _unite
      return if roots.size == 1

      roots.sort_by! { |root| @weights[root] }
      root = roots[-1]
      roots[0...-1].each do |r|
        @weights[root] += @weights[r]
        @parents[r] = root
      end
      root
    end

    # Unite nodes.
    #
    # @param nodes [Array[Object]] nodes
    #
    # @return [Object | nil] root of united nodes
    def unite(*nodes : T)
      roots = nodes.to_a.map { |node| root(node) }.uniq
      _unite
    end

    def unite!(*nodes : T)
      roots = nodes.to_a.map { |node| self[node] }.uniq
      _unite
    end


    macro _unite2
      return if x == y

      x, y = y, x if @weights[x] < @weights[y]
      @weights[x] += @weights[y]
      @parents[y] = x
    end

    def unite(node_1 : T, node_2 : T)
      x = root(node_1)
      y = root(node_2)
      _unite2
    end

    def unite!(node_1 : T, node_2 : T)
      x = self[node_1]
      y = self[node_2]
      _unite2
    end
  end
end

# uf = NetworkX::UnionFind(Int32).new([1, 2, 3])
uf = NetworkX::UnionFind(Int32).new

p uf.parents
p uf.weights


# p uf.same?(1, 2)
p uf[1] == uf[2]
p uf.unite!(1, 2, 3)
# p uf.same?(1, 2)

p uf.parents
p uf.weights

p uf.unite(1, 2)
p uf[1] == uf[2]
