# Transition are the movements from State to State.
class Transition
  DEFAULT_ARGS = {
    transition_name: 'T1',
    source: 'Start',
    destination: 'End',
    action: 'Step X',
    max_count: 0
  }.freeze

  attr_reader :transition_name, :max_count, :source, :destination, :action

  def initialize(args = {})
    args = DEFAULT_ARGS.merge(args)
    @max_count = args[:max_count]
    unless @max_count.is_a?(Integer)
      raise "max_count (#{@max_count}) must be an integer"
    end
    @source = args[:source]
    @destination = args[:destination]
    @action = args[:action]
    @transition_name = args[:transition_name]
  end

  def source?(source_name)
    @source == source_name
  end

  def not_max?(count)
    @max_count.zero? ? false : count < @max_count
  end

  def transition_data
    [@destination, @action]
  end
end
