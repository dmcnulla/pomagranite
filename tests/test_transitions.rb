require_relative '../lib/transition'
require 'test/unit'

# Test the Transition class
class TestTransition < Test::Unit::TestCase
  def test_defaults
    trans = Transition.new
    assert(trans.transition_name == 'T1', 'Wrong name.')
    assert(trans.source == 'Start', 'Wrong source.')
    assert(trans.destination == 'End', 'Wrong destination.')
    assert(trans.max_count == 0, 'Wrong max.')
    assert(trans.action == 'Step X', 'Wrong action.')
  end

  def test_non_defaults
    trans = Transition.new(transition_name: 'T2',
                           source: 'mysource',
                           destination: 'mydest',
                           max_count: 1,
                           action: 'myaction')
    assert(trans.transition_name == 'T2', 'Wrong name.')
    assert(trans.source == 'mysource', 'Wrong source.')
    assert(trans.destination == 'mydest', 'Wrong destination.')
    assert(trans.max_count == 1, 'Wrong max.')
    assert(trans.action == 'myaction', 'Wrong action.')
  end

  def test_bad_max_count
    assert_raise do
      Transition.new(max_count: 1.1)
    end
  end

  def test_transition_source
    trans = Transition.new(source: 'MyStart')
    assert(trans.source?('MyStart'), "source?() not working: #{trans.source}.")
  end

  def test_transition_action_false
    trans = Transition.new(source: 'MyStart')
    assert(!trans.source?('Start'), "source?() not working: #{trans.source}.")
  end

  def test_max_count
    trans = Transition.new(max_count: 3)
    assert(trans.not_max?(2), 'Max_count not working')
    assert(!trans.not_max?(3), 'Max_count not working')
  end

  def test_transition_data
    trans = Transition.new(destination: 'MyEnd', action: 'MyAction')
    assert(trans.transition_data[0] == 'MyEnd', 'transition_data not working.')
    assert(trans.transition_data[1] == 'MyAction', 'transition_data not working.')
  end
end
