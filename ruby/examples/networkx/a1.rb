#!ruby -W0
require 'networkx'

p graph = NetworkX::Graph.new(name: "Social Network", type: "undirected")
p graph.add_edge("Bangalore", "Chennai", name: "edge1")
graph.add_nodes(%w[A B])
graph.add_edge('A', 'B')
graph.add_edges([%w[A C], %w[C D]])
graph.add_node('E')

pp graph.nodes
pp graph.get_edge_data('A', 'B')
# pp graph.get_node_data(1)
# pp graph.edges

puts (graph.methods - Object.methods - Object.new.methods).sort
# add_edge
# add_edges
# add_node
# add_nodes
# add_weighted_edge
# add_weighted_edges
# adj
# clear
# directed?
# edge?
# edge_subgraph
# get_edge_data
# get_node_data
# graph
# multigraph?
# neighbours
# node?
# nodes
# number_of_edges
# number_of_nodes
# remove_edge
# remove_edges
# remove_node
# remove_nodes
# size
# subgraph
