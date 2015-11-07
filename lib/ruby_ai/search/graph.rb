require 'ruby_ai/search/vertex'
require 'ruby_ai/search/edge'

module RubyAi
  module Search
    class Graph
      class << self
        def undirected(&block)
          new(directed: false, &block)
        end

        def directed(&block)
          new(directed: true, &block)
        end

        private :new
      end

      attr_reader :vertices, :edges

      def initialize(directed:, &block)
        @vertices = []
        @edges    = []
        @directed = directed
        instance_eval(&block) if block_given?
      end

      def method_missing(method, *args, **kwargs, &block)
        send(method, *args, **kwargs, &block)
      end

      def vertex(name)
        @vertices.push(Vertex.new(name: name))
        self
      end

      def edge(from:, to:, cost: 1)
        start_vertex = find_or_create_vertex(name: from)
        end_vertex   = find_or_create_vertex(name: to)
        
        create_forward_edge(start_vertex: start_vertex, end_vertex: end_vertex, cost: cost)
        create_reverse_edge(start_vertex: start_vertex, end_vertex: end_vertex, cost: cost) unless @directed
        self
      end

      private

      def find_or_create_vertex(name:)
        unless @vertices.find { |vertex| vertex.name == name }
          vertex = Vertex.new(name: name)
          @vertices.push(vertex)
        end
        @vertices.find { |vertex| vertex.name == name }
      end

      def create_forward_edge(start_vertex:, end_vertex:, cost:)
        @edges.push(Edge.new(start_vertex: start_vertex, end_vertex: end_vertex, cost: cost))
      end

      def create_reverse_edge(start_vertex:, end_vertex:, cost:)
        @edges.push(Edge.new(start_vertex: end_vertex, end_vertex: start_vertex, cost: cost))
      end
    end
  end
end