require 'ruby_ai/search/graph_errors'

module RubyAi
  module Search
    class GraphProblem < RubyAi::Search::Core::Problem
      def initialize(graph:, initial_state:, goal:)
        @graph = graph
        unless valid_state?(state: initial_state)
          raise VertexNotFoundError
        end
        unless valid_state?(state: goal)
          raise VertexNotFoundError
        end
        super(initial_state: initial_state, goal: goal)
      end

      def actions(state:)
        actions = @graph.edges.select{ |edge| state == edge.start_vertex }
        if valid_state?(state: state)
          actions
        else
          raise VertexNotFoundError
        end
      end

      def result(state:, action:)
        if valid_action?(action: action) && actions(state: state).include?(action)
          action.end_vertex
        else
          raise EdgeNotFoundError
        end
      end

      def successor(state:)
        actions(state: state).map(&:end_vertex)
      end

      def goal_test(state:)
        state == @goal
      end

      def step_cost(from_state:, action:, to_state:)
        if result(state: from_state, action: action) == to_state
          action.cost
        else
          raise EdgeNotFoundError
        end
      end

      private 

      def valid_state?(state:)
        @graph.vertices.include?(state)
      end

      def valid_action?(action:)
        @graph.edges.include?(action)
      end
    end
  end
end