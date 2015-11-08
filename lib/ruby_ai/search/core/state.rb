module RubyAi
  module Search
    module Core
      class State
        attr_reader :name

        def initialize(name: name)
          @name = name
        end

        def ==(other)
          self.class == other.class && 
          @name == other.name
        end

        def to_s
          @name
        end
      end
    end
  end
end