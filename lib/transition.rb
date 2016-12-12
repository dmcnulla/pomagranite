# Transition are the movements from State to State.
class Transition
  DEFAULT_ARGS = {
    current_name: 'T1',
    source: 'Start',
    destination: 'End',
    code: 'Step X',
    max_count: 0
  }.freeze

  attr_reader :current_name
  attr_reader :max_count
  attr_reader :source
  attr_reader :destination
  attr_reader :code

  def initialize(args = {})
    args = DEFAULT_ARGS.merge(args)
    @max_count = args[:max_count]
    unless @max_count.is_a?(Integer)
      raise "max_count (#{@max_count}) must be an integer"
    end
    @source = args[:source]
    @destination = args[:destination]
    @code = args[:code]
    @current_name = args[:current_name]
  end

  def source?(source_name)
    @source == source_name
  end

  def not_max?(count)
    @max_count.zero? ? false : count < @max_count
  end

  def transition_data
    [@destination, @code]
  end
end
