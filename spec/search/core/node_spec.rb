require 'spec_helper'

describe RubyAi::Search::Core::Node do
  let(:state_a) { RubyAi::Search::Core::State.new(name: :a) }
  let(:state_b) { RubyAi::Search::Core::State.new(name: :b) }
  let(:state_c) { RubyAi::Search::Core::State.new(name: :c) }
  let(:state_d) { RubyAi::Search::Core::State.new(name: :d) }
  
  let(:action_a_b) { RubyAi::Search::Core::Action.new(start_state: state_a, end_state: state_b, cost: 1) }
  let(:action_a_c) { RubyAi::Search::Core::Action.new(start_state: state_a, end_state: state_c, cost: 2) }
  let(:action_b_d) { RubyAi::Search::Core::Action.new(start_state: state_b, end_state: state_d, cost: 3) }
  let(:action_c_d) { RubyAi::Search::Core::Action.new(start_state: state_c, end_state: state_d, cost: 4) }

  let(:problem) { RubyAi::Search::Core::Problem.new(initial_state: state_a, goal: state_d) } 
  let(:root_node) { RubyAi::Search::Core::Node.new(state: state_a) }
  let(:node_b) { RubyAi::Search::Core::Node.new(state: state_b, parent: root_node, action: action_a_b, path_cost: root_node.path_cost + action_a_b.cost) }
  let(:node_c) { RubyAi::Search::Core::Node.new(state: state_c, parent: root_node, action: action_a_c, path_cost: root_node.path_cost + action_a_c.cost) }
  let(:node_d) { RubyAi::Search::Core::Node.new(state: state_d, parent: node_c,    action: action_c_d, path_cost: node_c.path_cost + action_c_d.cost) }

  describe '#child_node' do
    
    before do
      expect(problem).to receive(:result).with(state: node.state, action: action).and_return(action.end_state)
      expect(problem).to receive(:path_cost).with(cost: node.path_cost, from_state: node.state, action: action, to_state: action.end_state).and_call_original
      expect(problem).to receive(:step_cost).with(from_state: node.state, action: action, to_state: action.end_state).and_return(action.cost)
    end

    context 'given the root node' do
      let(:node) { root_node }
      let(:action) { action_a_b }

      it 'should create a new node with state the resulting state' do
        expect(node.child_node(problem: problem, action: action).state).to eq state_b
      end

      it 'should create a new node with parent the root node' do
        expect(node.child_node(problem: problem, action: action).parent).to eq node
      end

      it 'should create a new node with path cost the action\'s cost' do
        expect(node.child_node(problem: problem, action: action).path_cost).to eq action.cost
      end
    end

    context 'given a child node' do
      let(:node) { node_b }
      let(:action) { action_b_d }

      it 'should create a new node with state the resulting state' do
        expect(node.child_node(problem: problem, action: action).state).to eq state_d
      end

      it 'should create a new node with parent the parent node' do
        expect(node.child_node(problem: problem, action: action).parent).to eq node
      end

      it 'should create a new node with path cost the sum action\'s cost and parent node\'s path cost' do
        expect(node.child_node(problem: problem, action: action).path_cost).to eq(node.path_cost + action.cost)
      end
    end
  end

  describe '#expand' do
    
    before do
      expect(problem).to receive(:actions).with(state: node.state).and_return([action_a_b, action_a_c])
      expect(node).to receive(:child_node).with(problem: problem, action: action_a_b).and_return(node_b)
      expect(node).to receive(:child_node).with(problem: problem, action: action_a_c).and_return(node_c)
    end

    let(:node) { root_node }

    it 'should return all reachable nodes with one action' do
      expect(node.expand(problem: problem)).to contain_exactly(node_b, node_c)
    end 
  end

  describe '#path' do
    let(:node) { node_d }

    it 'should return all parents until root node' do
      expect(node.path).to eq([root_node, node_c, node_d])
    end
  end

  describe '#path' do
    let(:node) { node_d }

    it 'should return all actions from root_node to node' do
      expect(node.solution).to eq([action_a_c, action_c_d])
    end
  end

  describe '#to_s' do
    context 'given a state without a parent' do
     it 'should return \'node: {state: state, parent: , action: , path_cost: path_cost\'}' do
        expect(root_node.to_s).to eq 'node: {state: a, parent: , action: , path_cost: 0}'
      end
    end

    context 'given a state with a parent' do
     it 'should return \'node: {state: state, parent: parent.state, action: (start_state: start_state, end_state: end_state, cost: cost), path_cost: path_cost\'}' do
        expect(node_b.to_s).to eq 'node: {state: b, parent: a, action: (start_state: a, end_state: b, cost: 1), path_cost: 1}'
      end
    end
  end
end