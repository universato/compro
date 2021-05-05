#!ruby -W0
require 'networkx'

module NetworkX
  class UnionFind
    def inspect
      "#<NetworkX::UnionFind #{instance_variables_stat}>"
    end
    alias inspect to_s

    private
      def instance_variables_stat
        instance_variables.map{ |sym| "#{sym}=#{instance_variable_get(sym)}" }.join
      end
  end
end

n = 5

uf = NetworkX::UnionFind.new(['A', 'B', 'C', 'D'])
puts uf.to_s
puts uf.inspect
