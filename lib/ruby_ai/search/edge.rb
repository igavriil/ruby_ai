module RubyAi
  module Search
    class Edge
      attr_reader :start_vertex, :end_vertex, :cost

      def initialize(start_vertex:, end_vertex:, cost:)
        @start_vertex = start_vertex
        @end_vertex = end_vertex
        @cost = cost
      end

      def ==(other)
        self.class == other.class && 
        @start_vertex == other.start_vertex &&
        @end_vertex   == other.end_vertex &&
        @cost         == other.cost 
      end

      def to_s
        "edge: #{@start_vertex} (#{@cost}) #{@end_vertex}"
      end
    end 
  end
end