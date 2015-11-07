require 'spec_helper'

describe RubyAi::Search::Vertex do
  subject { RubyAi::Search::Vertex.new(name: :a) }
  
  describe '#==' do
    context 'when vertices names are equal' do
      let(:other) { RubyAi::Search::Vertex.new(name: :a) }

      it 'should return true' do
        expect(subject == other).to be true
      end
    end

    context 'when vertices names are not equal' do
      let(:other) { RubyAi::Search::Vertex.new(name: :b) }

      it 'should return false' do
        expect(subject == other).to be false
      end
    end
  end

  describe '#to_s' do
    it 'should return \'vertex: name\'' do
      expect(subject.to_s).to eq 'vertex: a'
    end
  end
end