module RubyAi
  module Search
    module Core
      class Action
        attr_reader :start_state, :end_state, :cost

        def initialize(start_state:, end_state:, cost:)
          @start_state = start_state
          @end_state = end_state
          @cost = cost
        end

        def ==(other)
          self.class == other.class && 
          @start_state == other.start_state &&
          @end_state   == other.end_state &&
          @cost        == other.cost 
        end

        def to_s
          "(start_state: #{@start_state.to_s}, end_state: #{@end_state.to_s}, cost: #{@cost})"
        end
      end
    end
  end
end