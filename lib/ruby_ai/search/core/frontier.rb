module RubyAi
  module Search
    module Core
      class Frontier

        attr_reader :store

        def initialize
          @store = []
        end

        def append(element:)
          raise NotImplementedError
        end

        def pop
          raise NotImplementedError
        end

        def size
          @store.size
        end

        def empty?
          @store.empty?
        end

        def include?(element:)
          @store.include?(element)
        end
      end

      class Queue < Frontier

        def append(element:)
          @store.unshift(element)
          self
        end

        def pop
          @store.pop
        end
      end

      class Stack < Frontier

        def append(element:)
          @store.push(element)
          self
        end

        def pop
          @store.pop
        end
      end

      class PriorityQueue < Frontier

        def initialize(order: nil)
          @order = Proc.new { |priorities| priorities.min }
          @store = Hash.new { |hash, key| hash[key] = [] }
        end

        def append(element:, priority:)
          @store[priority].push(element)
          self
        end

        def pop
          clean_store && @store[max_priority].pop
        end

        def empty?
          clean_store && super
        end

        def size
          @store.values.flatten.size
        end
        
        def include?(element:)
          @store.values.flatten.include?(element)
        end

        def store
          clean_store
          super
        end

        private

        def max_priority
          @order.call(@store.keys)
        end

        def clean_store
          @store.delete_if { |priority, elements| elements.empty? }
        end
      end
    end
  end
end