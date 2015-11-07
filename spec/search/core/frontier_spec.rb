require 'spec_helper'

describe RubyAi::Search::Core::Queue do
  let(:empty_queue) { subject }
  let(:non_empty_queue) do
    subject.append(element: 5)
    subject.append(element: 15)
  end

  describe '#append' do

    context 'given store with no elements' do
      before do
        expect(empty_queue.size).to eq 0
      end

      it 'should add element to the store' do
        empty_queue.append(element: 10)
        expect(empty_queue.size).to eq 1
      end
    end

    context 'given store with elements' do
      before do
        expect(non_empty_queue.size).to eq 2
      end

      it 'should add element to front of the store' do
        non_empty_queue.append(element: 10)
        expect(non_empty_queue.size).to eq 3
      end
    end
  end

  describe '#pop' do
    context 'given store with no elements' do
      it 'should return nil' do
        expect(empty_queue.pop).to be_nil
      end
    end

    context 'given store with elements' do
      it 'should return the first appended element' do
        expect(non_empty_queue.pop).to eq 5
      end
    end
  end

  describe '#empty?' do
    context 'given store with no elements' do
      it 'should return true' do
        expect(empty_queue.empty?).to be true
      end
    end

    context 'given store with elements' do
      it 'should return false' do
        expect(non_empty_queue.empty?).to be false
      end
    end
  end

  describe '#include?' do 
    context 'given element is in frontier' do
      it 'should return true' do
        expect(non_empty_queue.include?(element: 15)).to be true
      end
    end

    context 'given element not in frontier' do
      it 'should return false' do
        expect(non_empty_queue.include?(element: 25)).to be false
      end
    end
  end
end

describe RubyAi::Search::Core::Stack do
  let(:empty_stack) { subject }
  let(:non_empty_stack) do
    subject.append(element: 5)
    subject.append(element: 15)
  end

  describe '#append' do
    context 'given store with no elements' do
      before do
        expect(empty_stack.size).to eq 0
      end

      it 'should add element to the store' do
        empty_stack.append(element: 10)
        expect(empty_stack.size).to eq 1
      end
    end

    context 'given store with elements' do
      before do
        expect(non_empty_stack.size).to eq 2
      end

      it 'should add element to end of the store' do
        non_empty_stack.append(element: 10)
        expect(non_empty_stack.size).to eq 3
      end
    end
  end

  describe '#pop' do
    context 'given store with no elements' do
      it 'should return nil' do
        expect(empty_stack.pop).to be_nil
      end
    end

    context 'given store with elements' do
      it 'should return the last appended element' do
        expect(non_empty_stack.pop).to eq 15
      end
    end
  end

  describe '#empty?' do
    context 'given store with no elements' do
      it 'should return true' do
        expect(empty_stack.empty?).to be true
      end
    end

    context 'given store with elements' do
      it 'should return false' do
        expect(non_empty_stack.empty?).to be false
      end
    end
  end

  describe '#include?' do 
    context 'given element is in frontier' do
      it 'should return true' do
        expect(non_empty_stack.include?(element: 15)).to be true
      end
    end

    context 'given element not in frontier' do
      it 'should return false' do
        expect(non_empty_stack.include?(element: 25)).to be false
      end
    end
  end
end

describe RubyAi::Search::Core::PriorityQueue do
  let(:empty_priority_queue) { subject }
  let(:non_empty_priority_queue) do
    subject.append(element: 5, priority: 3)
    subject.append(element: 15, priority: 5)
    subject.append(element: 20, priority: 3)
  end

  describe '#append' do
    context 'given store with no elements' do
      before do
        expect(empty_priority_queue.size).to eq 0
      end

      it 'should add element to the store' do
        empty_priority_queue.append(element: 10, priority: 5)
        expect(empty_priority_queue.size).to eq 1
      end
    end

    context 'given store with elements' do
      before do
        expect(non_empty_priority_queue.size).to eq 3
      end

      it 'should add element to the store' do
        non_empty_priority_queue.append(element: 10, priority: 5)
        expect(non_empty_priority_queue.size).to eq 4
      end
    end
  end

  describe '#pop' do
    context 'given store with no elements' do
      it 'should return nil' do
        expect(empty_priority_queue.pop).to be_nil
      end
    end

    context 'given store with elements' do
      context 'given one element with min priority' do
        before do
          non_empty_priority_queue.append(element: 50, priority: 1)
        end
        it 'should return the element with min priority' do
          expect(non_empty_priority_queue.pop).to eq 50
        end
      end

      context 'given multiple elements with min priority' do
        it 'should return the last appended element with min priority' do
          expect(non_empty_priority_queue.pop).to eq 20
        end
      end
    end
  end

  describe '#empty?' do
    context 'given store with no elements' do
      it 'should return true' do
        expect(empty_priority_queue.empty?).to be true
      end
    end

    context 'given store with elements' do
      it 'should return false' do
        expect(non_empty_priority_queue.empty?).to be false
      end
    end
  end

  describe '#include?' do 
    context 'given element is in frontier' do
      it 'should return true' do
        expect(non_empty_priority_queue.include?(element: 15)).to be true
      end
    end

    context 'given element not in frontier' do
      it 'should return false' do
        expect(non_empty_priority_queue.include?(element: 25)).to be false
      end
    end
  end
end