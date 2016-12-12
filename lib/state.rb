class State
  DEFAULT_ARGS = {
    state_name: 'Start',
    transitions: ['T1'],
    verification: 'Verify(X)',
    max_count: 0
  }.freeze

  attr_reader :state_name, :transitions, :verification, :max_count

  def initialize(args = {})
    args = DEFAULT_ARGS.merge(args)
    @transitions = args[:transitions]
    @verification = args[:verification]
    @state_name = args[:state_name]
    @max_count = args[:max_count]
    unless @max_count.is_a?(Integer)
      raise "max_count (#{@max_count}) must be an integer"
    end
  end

  def pick_transition()
    Random.new()
    @transitions[Random.rand(@transitions.length)]
  end

  def not_max?(count)
    @max_count.zero? ? false : count < @max_count
  end

  def state_data
    [@verification, @state_name]   
  end
end
