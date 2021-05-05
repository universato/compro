#!ruby -W1
require 'networkx'

n, m = 2, 1
a = [3, 2]
b = [3, 3]
r = [100000, 100000, 100000]
e = a + b + r

# Yet to be implemented
g = NetworkX::DiGraph.new
g.add_node(-1, demand: 3 * m)

n.times do |i|
    x, q = e[i], 0
    (-3..-1).each do |j|
      g.add_node(j, demand: -m)
      x *= e[n + i]
      g.add_weighted_edges([[j, i], [i, n], [0 - x % e[i], x - 1]], [1, 1, 1])
      q = x
    end
end

# pp g
puts (g.methods - Object.methods - Object.new.methods).sort
# puts -min_cost_flow_cost(g)
# puts g.min_cost_flow_cost

NetworkX.edmondskarp(g, 0, n - 1)

# for i in range(N):
#   x,p=E[i],0
#   for j in-3,-2,-1:
#     G.add_node(j,demand=-M);
#     x*=E[N+i];
#     G.add_weighted_edges_from([(j,i,0-x%E[j]),(i,N,x-p)],capacity=1);
#     p=x
#  print(-min_cost_flow_cost(G))

# p g

__END__
# in
2 1
3 2
3 3
100000 100000 100000
# out
81


# Ruby 2.7
# networkx.rb/lib/networkx/digraph.rb:20: warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call
# networkx.rb/lib/networkx/graph.rb:17: warning: The called method `initialize' is defined here
# networkx.rb/lib/networkx/digraph.rb:53: warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call
# networkx.rb/lib/networkx/graph.rb:67: warning: The called method `add_node' is defined here

# Ruby 3.0 doesn't work
# networkx.rb/lib/networkx/graph.rb:17:in `initialize': wrong number of arguments (given 1, expected 0) (ArgumentError)
