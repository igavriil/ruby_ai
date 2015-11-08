require 'spec_helper'

describe RubyAi::Search::GraphProblem do
  
  let(:graph) do
    RubyAi::Search::Graph.directed do
      edge from: :a, to: :b, cost: 1
      edge from: :a, to: :c, cost: 2
      edge from: :b, to: :d, cost: 3
      edge from: :c, to: :d, cost: 4
      edge from: :c, to: :e, cost: 5
    end
  end

  let(:initial_state) { RubyAi::Search::Vertex.new(name: :a) }
  let(:goal) { RubyAi::Search::Vertex.new(name: :e) }
  let(:invalid_state) { RubyAi::Search::Vertex.new(name: :f) }
  let(:invalid_action) { RubyAi::Search::Edge.new(start_vertex: initial_state, end_vertex: invalid_state, cost: 1) }
  
  it { expect(RubyAi::Search::GraphProblem).to be < RubyAi::Search::Core::Problem }

  describe '#initialize' do
    context 'when initial state not in graph vertices' do
      let(:initial_state) { invalid_state }
      
      it 'should raise VertexNotFoundError' do
        expect do
          RubyAi::Search::GraphProblem.new(graph: graph, initial_state: initial_state, goal: goal)
        end.to raise_error(VertexNotFoundError)
      end
    end

    context 'when goal not in graph vertices' do
      let(:goal) { invalid_state }

      it 'should raise VertexNotFoundError' do
        expect do
          RubyAi::Search::GraphProblem.new(graph: graph, initial_state: initial_state, goal: goal)
        end.to raise_error(VertexNotFoundError)
      end
    end

    context 'when initial state and goal in graph vertices' do
      it 'should create a valid instance' do
        expect do
          RubyAi::Search::GraphProblem.new(graph: graph, initial_state: initial_state, goal: goal)
        end.not_to raise_error
      end
    end
  end

  subject { RubyAi::Search::GraphProblem.new(graph: graph, initial_state: initial_state, goal: goal) }

  let(:vertex_a) { RubyAi::Search::Vertex.new(name: :a) }
  let(:vertex_b) { RubyAi::Search::Vertex.new(name: :b) }
  let(:vertex_c) { RubyAi::Search::Vertex.new(name: :c) }
  let(:vertex_d) { RubyAi::Search::Vertex.new(name: :d) }

  let(:edge_a_b) { RubyAi::Search::Edge.new(start_vertex: vertex_a, end_vertex: vertex_b, cost: 1) }
  let(:edge_a_c) { RubyAi::Search::Edge.new(start_vertex: vertex_a, end_vertex: vertex_c, cost: 2) }
  let(:edge_b_d) { RubyAi::Search::Edge.new(start_vertex: vertex_b, end_vertex: vertex_d, cost: 3) }

  describe '#actions' do
    context 'when state not in graph vertices' do
      let(:state) { invalid_state }

      it 'should raise VertexNotFoundError' do
        expect{ subject.actions(state: state) }.to raise_error(VertexNotFoundError)
      end
    end

    context 'when state in graph vertices' do
      let(:state) { RubyAi::Search::Vertex.new(name: :a) }
      
      it 'should return all edges starting from state' do
        expect(subject.actions(state: state)).to contain_exactly(edge_a_b, edge_a_c)
      end
    end
  end

  describe '#result' do
    context 'when action not in graph edges' do
      let(:action) { invalid_action }

      it 'should raise EdgeNotFoundError' do
        expect{ subject.result(state: initial_state, action: action) }.to raise_error(EdgeNotFoundError)
      end
    end

    context 'when action not state\'s actions' do
      let(:action) { edge_b_d }

      it 'should raise EdgeNotFoundError' do
        expect{ subject.result(state: initial_state, action: action) }.to raise_error(EdgeNotFoundError)
      end
    end

    context 'when action in states\'s actions' do
      let(:action) { edge_a_b }

      it 'should return action\'s end vertex' do
        expect(subject.result(state: initial_state, action: action)).to eq vertex_b
      end
    end
  end

  describe '#successor' do
    context 'when state not in graph vertices' do
      let(:state) { invalid_state }

      it 'should raise VertexNotFoundError' do
        expect{ subject.successor(state: state) }.to raise_error(VertexNotFoundError)
      end
    end

    context 'when state in graph vertices' do
      let(:state) { RubyAi::Search::Vertex.new(name: :a) }
      
      it 'should return all posible states reachable with one action' do
        expect(subject.successor(state: state)).to contain_exactly(vertex_b, vertex_c)
      end
    end
  end

  describe '#goal_test' do
    context 'when state is goal' do
      let(:state) { goal }

      it 'should return true' do
        expect(subject.goal_test(state: state)).to be true
      end
    end

    context 'when state is not goal' do
      let(:state) { vertex_c }

      it 'should return false' do
        expect(subject.goal_test(state: state)).to be false
      end
    end
  end

  describe '#step_cost' do
    context 'when action changes state from \'from_state\' to \'to_state\'' do
      it 'should return the edge cost' do
        expect(subject.step_cost(from_state: vertex_a, action: edge_a_c, to_state: vertex_c)).to eq edge_a_c.cost
      end
    end

    context 'when action does not changes state from \'from_state\' to \'to_state\'' do
      it 'should raise EdgeNotFoundError' do
        expect{ subject.step_cost(from_state: vertex_a, action: edge_a_b, to_state: vertex_c) }.to raise_error(EdgeNotFoundError)
      end
    end
  end

  describe '#path_cost' do
    let(:cost) { 10 }

    context 'when action changes state from \'from_state\' to \'to_state\'' do
      it 'should return the sum cost and edge cost' do
        expect(subject.path_cost(cost: cost, from_state: vertex_a, action: edge_a_c, to_state: vertex_c)).to eq(cost + edge_a_c.cost)
      end
    end

    context 'when action does not changes state from \'from_state\' to \'to_state\'' do
      it 'should raise EdgeNotFoundError' do
        expect{ subject.path_cost(cost: cost, from_state: vertex_a, action: edge_a_b, to_state: vertex_c) }.to raise_error(EdgeNotFoundError)
      end
    end
  end
end