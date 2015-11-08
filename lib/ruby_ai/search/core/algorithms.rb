require 'set'

module RubyAi
  module Search
    module Core
      module Algorithms

        def self.included(base)
          base.send :include, InstanceMethods
        end

        module InstanceMethods

          def tree_search(problem:, frontier:)
            initialize_frontier(frontier: frontier, problem: problem)
            until frontier.empty? do
              node = frontier.pop
              return node.solution if problem.goal_test(state: node.state)
              node.expand(problem: problem).each do |child_node|
                frontier.append(child_node)
              end
            end
            return nil
          end

          def graph_search(problem:, frontier:, check_expanded: false)
            initialize_frontier(frontier: frontier, problem: problem)
            explored_set = Set.new
            until frontier.empty? do
              node = frontier.pop
              return node.solution if problem.goal_test(state: node.state)
              explored_set.add(node)
              node.expand(problem: problem).each do |child_node|
                if !explored_set.include?(child_node) && !frontier.include?(element: child_node)
                  return child_node.solution if problem.goal_test(state: child_node.state) if check_expanded
                  frontier.append(element: child_node)
                end
              end
            end
            return nil
          end

          private 

          def initialize_frontier(frontier:, problem:)
            frontier.append(element: Node.new(state: problem.initial_state))
          end
        
        end
      end
    end
  end
end