require 'spec_helper'

describe RubyAi::Search::Edge do
  subject { RubyAi::Search::Edge.new(start_vertex: :a, end_vertex: :b, cost: 2) }
  
  describe '#==' do
    context 'when all attributes are equal' do
      let(:other) { RubyAi::Search::Edge.new(start_vertex: :a, end_vertex: :b, cost: 2) }

      it 'should return true' do
        expect(subject == other).to be true
      end
    end

    context 'when start_vertices are not equal' do
      let(:other) { RubyAi::Search::Edge.new(start_vertex: :c, end_vertex: :b, cost: 2) }

      it 'should return false' do
        expect(subject == other).to be false
      end
    end

     context 'when end_vertices are not equal' do
      let(:other) { RubyAi::Search::Edge.new(start_vertex: :a, end_vertex: :c, cost: 2) }

      it 'should return false' do
        expect(subject == other).to be false
      end
    end

     context 'when costs are not equal' do
      let(:other) { RubyAi::Search::Edge.new(start_vertex: :a, end_vertex: :b, cost: 3) }

      it 'should return false' do
        expect(subject == other).to be false
      end
    end
  end

  describe '#to_s' do
    it 'should return \'edge: start_vertex (cost) end_vertex\'' do
      expect(subject.to_s).to eq 'edge: a (2) b'
    end
  end
end