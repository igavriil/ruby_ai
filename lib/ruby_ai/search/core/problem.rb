module RubyAi
  module Search
    module Core
       class Problem

        attr_reader :initial_state, :goal

        def initialize(initial_state:, goal: nil)
          @initial_state = initial_state
          @goal = goal
        end

        # a description of the possible actions available
        # given a *state* returns the set of actions that can be
        # exectuted in *state*
        def actions(state:)
          raise NotImplementedError
        end

        # transition model: a description what each action does
        # given a *state* and an *action* returns the state that results
        # from doing action *action* in state *state*
        def result(state:, action:)
          raise NotImplementedError
        end

        # refer to any state reachable by a single action
        # given a *state* returns the states that result from doing
        # any single action in state *state*
        def successor(state:)
          raise NotImplementedError
        end

        # determines whether a given state is a goal state
        def goal_test(state:)
          raise NotImplementedError
        end

        # assigns a numeric cost to each step
        # given a *from_state* and an action *action* in order to reach
        # a *to_state* returns the step cost of taking this action
        def step_cost(from_state:, action:, to_state:)
          raise NotImplementedError
        end

        # assigns a numeric cost to each step
        # given a previous cost a *from_state* and an action *action* in order 
        # to reacha *to_state* returns *previous cost* + step_cost
        def path_cost(cost:, from_state:, action:, to_state:)
          cost + step_cost(from_state: from_state, action: action, to_state: to_state)
        end
      end
    end
  end
end
