#!ruby -W0
require 'networkx'

graph = NetworkX::Graph.new
graph.add_node('A', name: "A", color: 'red')
graph.add_nodes(%w[S T])
graph.add_edge('S', 'A', name: "A-edge", color: 'red')
graph.add_edge('T', 'A')
graph.add_edges([['X', 'Y'], ['Z', 'W']])
p graph.get_edge_data('S', 'T') # => nil
p graph.get_edge_data('A', 'S') # => {:name=>"A-edge", :color=>"red"}
p graph.get_edge_data('A', 'T') # => {}
pp graph

# @adjって、隣接リストのことか。隣接行列ではないはず。
# graph.get_edge_data('S', 'none') # 頂点がないときはエラーになるが、頂点どうしがあるが、edgeが存在しない場合はnilを返す。

# Graph#add_nodesは、配列で複数の頂点を追加する。可変長引数じゃないのがいまいちな感じもする。速度重視だとこうなる？
# Graph#add_nodesは、名前などを登録することができない。Graph#add_nodeは、名前登録ができる。

# Graph#add_edge と #add_node は、引数でオプションを指定して情報を持たせられる。
# Graph#add_edgesは、1配列を引数に`[['X', 'Y'], ['Z', 'W']]`みたいな感じで指定する。2要素の配列をたくさん持つ配列。
# このあたりは整合してるな。
# Graph作るときにもオプションを指定できる。
