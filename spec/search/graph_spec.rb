require 'spec_helper'

describe RubyAi::Search::Graph do
  subject { RubyAi::Search::Graph }
  
  let(:vertex_a) { RubyAi::Search::Vertex.new(name: :a) }
  let(:vertex_b) { RubyAi::Search::Vertex.new(name: :b) }

  let(:edge_a_b) { RubyAi::Search::Edge.new(start_vertex: vertex_a, end_vertex: vertex_b, cost: 1) }
  let(:edge_b_a) { RubyAi::Search::Edge.new(start_vertex: vertex_b, end_vertex: vertex_a, cost: 1) }
  
  describe '#vertex' do
    let(:graph) { subject.send(:new, directed: true) }
    
    before { expect(graph.vertex(:a)).to be_a RubyAi::Search::Graph }
    
    it 'should create a Vertex and append to vertices list' do
      expect(graph.vertices).to contain_exactly(vertex_a)
    end
  end

  describe '#edge' do
    context 'given an undirected graph' do
      let(:graph) { subject.send(:new, directed: false) }

      before { expect(graph.edge(from: :a, to: :b)).to be_a RubyAi::Search::Graph }

      it 'should create a Vertex with name a and append to vertices list' do
        expect(graph.vertices).to include(vertex_a)
      end

      it 'should create a Vertex with name b and append to vertices list' do
        expect(graph.vertices).to include(vertex_b)
      end

      it 'should create a forward direction Vertex and append to edges list' do
        expect(graph.edges).to include(edge_a_b)
      end

      it 'should create a backward direction Edge and append to edges list' do
        expect(graph.edges).to include(edge_b_a)
      end
    end

    context 'given a directed graph' do
      let(:graph) { subject.send(:new, directed: true) }
      
      before { expect(graph.edge(from: :a, to: :b)).to be_a RubyAi::Search::Graph }

      it 'should create a Vertex with name a and append to vertices list' do
        expect(graph.vertices).to include(vertex_a)
      end

      it 'should create a Vertex with name b and append to vertices list' do
        expect(graph.vertices).to include(vertex_b)
      end

      it 'should create a forward direction Edge and append to edges list' do
        expect(graph.edges).to include(edge_a_b)
      end
    end
  end

  describe '.directed' do
    it 'should create a graph with directed equal to true' do
      expect(subject).to receive(:new).with(directed: true).and_call_original
      expect(subject.directed).to be_a RubyAi::Search::Graph
    end
  end
  
  describe '.undirected' do
    it 'should create a graph with directed equal to false' do
      expect(subject).to receive(:new).with(directed: false).and_call_original
      expect(subject.undirected).to be_a RubyAi::Search::Graph
    end
  end
end
