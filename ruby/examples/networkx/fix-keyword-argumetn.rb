require 'networkx'
g = NetworkX::MultiDiGraph.new

# Ruby 2.7 issues the following deprecated warning:
# lib/networkx/digraph.rb:20: warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call
# lib/networkx/graph.rb:17: warning: The called method `initialize' is defined here

# Ruby 3.0 doesn't work:
# lib/networkx/graph.rb:17:in `initialize': wrong number of arguments (given 1, expected 0) (ArgumentError)
#         from lib/networkx/digraph.rb:20:in `initialize'
#         from sample.rb:2:in `new'
#         from sample.rb:2:in `<main>'
