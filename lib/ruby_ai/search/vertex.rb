module RubyAi
  module Search
    class Vertex
      attr_reader :name

      def initialize(name:)
        @name = name
      end

      def ==(other)
        self.class == other.class && 
        @name == other.name
      end

      def to_s
        "vertex: #{name}"
      end
    end
  end
end
