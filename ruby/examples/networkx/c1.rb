#!ruby -W0
require 'networkx'

p NetworkX::Graph.superclass        # Object
p NetworkX::DiGraph.superclass      # NetworkX::Graph
p NetworkX::MultiGraph.superclass   # NetworkX::Graph
p NetworkX::MultiDiGraph.superclass # NetworkX::DiGraph

# p NetworkX::Graph.ancestors
# p NetworkX::DiGraph.ancestors
# p NetworkX::MultiGraph.ancestors
# p NetworkX::MultiDiGraph.ancestors



# graph = NetworkX::Graph.new
# graph.add_node('A', name: "A", color: 'red')
# graph.add_nodes(%w[S T])
# graph.add_edge('S', 'A', name: "A-edge", color: 'red')
