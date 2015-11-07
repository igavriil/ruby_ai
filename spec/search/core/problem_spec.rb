require 'spec_helper'

describe RubyAi::Search::Core::Problem do
  subject { RubyAi::Search::Core::Problem.new(initial_state: :state)}

  describe '#actions' do
    it 'shoudl raise NotImplementedError' do
      expect{subject.actions(state: :state)}.to raise_error(NotImplementedError)
    end
  end

  describe '#result' do
    it 'shoudl raise NotImplementedError' do
      expect{subject.result(state: :state, action: :action)}.to raise_error(NotImplementedError)
    end
  end

  describe '#successor' do
    it 'shoudl raise NotImplementedError' do
      expect{subject.successor(state: :state)}.to raise_error(NotImplementedError)
    end
  end

  describe '#goal_test' do
    it 'shoudl raise NotImplementedError' do
      expect{subject.goal_test(state: :state)}.to raise_error(NotImplementedError)
    end
  end

  describe '#step_cost' do
    it 'shoudl raise NotImplementedError' do
      expect{subject.step_cost(from_state: :from_state, action: :action, to_state: :to_state)}.to raise_error(NotImplementedError)
    end
  end

  describe '#path_cost' do
    it 'should sum up current cost with step cost' do
      expect(subject).to receive(:step_cost).with(from_state: :from_state, action: :action, to_state: :to_state).and_return 5
      expect(subject.path_cost(cost: 5, from_state: :from_state, action: :action, to_state: :to_state)).to eq 10
    end
  end
end
