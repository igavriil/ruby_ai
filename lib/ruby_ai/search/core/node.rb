module RubyAi
  module Search
    module Core
      class Node
        attr_accessor :state, :parent, :action, :path_cost

        def initialize(state:, parent: nil, action: nil, path_cost: 0)
          @state     = state
          @parent    = parent
          @action    = action
          @path_cost = path_cost
        end

        def expand(problem:)
          reachable_nodes = []
          problem.actions(state: @state).each do |action|
            reachable_nodes.push(child_node(problem: problem, action: action))
          end
          reachable_nodes
        end

        def solution
          path[1..-1].map(&:action)
        end

        def path(node: self)
          path_from_root = []
          until node.nil? do
            path_from_root.unshift(node)
            node = node.parent
          end
          path_from_root
        end

        def child_node(problem:, parent: self, action:)
          state     = problem.result(state: parent.state, action: action)
          parent    = parent
          action    = action
          path_cost = problem.path_cost(cost: parent.path_cost, from_state: parent.state, action: action, to_state: state)
          Node.new(state: state, parent: parent, action: action, path_cost: path_cost)
        end

        def to_s
          "node: {state: #{@state.to_s}, parent: #{@parent ? @parent.state.to_s: nil}, action: #{@action.to_s}, path_cost: #{@path_cost}}"
        end

        def eql?(other)
          self.class == other.class && @state == other.state
        end

        def ==(other)
          self.class == other.class && 
          @state == other.state &&
          @parent == other.parent
          @action == other.action
          @path_cost == other.path_cost
        end

        def hash
          [@state].hash
        end
      end
    end
  end
end
