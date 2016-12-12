require_relative 'transition_array'

class State
  DEFAULT_ARGS = {
    current_name: 'Start',
    transitions: ['T1'],
    code: 'Verify(X)',
    max_count: 0
  }.freeze

  attr_reader :current_name
  attr_reader :transition_array
  attr_reader :code
  attr_reader :max_count

  def initialize(args = {})
    args = DEFAULT_ARGS.merge(args)
    @current_name = args[:current_name]
    @transition_array = TransitionArray.new(args[:transitions])
    @code = args[:code]
    @max_count = args[:max_count]
    unless @max_count.is_a?(Integer)
      raise "max_count (#{@max_count}) must be an integer"
    end
  end

  def next_transition
    @transition_array.next
  end

  def not_max?(count)
    @max_count.zero? ? false : count < @max_count
  end

  def state_data
    [@verification, @current_name]   
  end
end
