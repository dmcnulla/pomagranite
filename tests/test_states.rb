require_relative '../lib/state'
require 'test/unit'

# Test the State class
class TestState < Test::Unit::TestCase
  def test_defaults
    state = State.new
    assert_equal(state.state_name, 'Start', 'Wrong name.')
    assert_equal(state.transitions[0], 'T1', 'Wrong transition array.')
    assert_equal(state.verification, 'Verify(X)', 'Wrong verification.')
    assert_equal(state.max_count, 0, 'Wrong max.')
  end

  def test_non_defaults
    state = State.new(state_name: 'MyStart',
                      transitions: ['T1', 'T2'],
                      verification: 'Verify(X, Y)',
                      max_count: 1)
    assert_equal(state.state_name, 'MyStart', 'Wrong name.')
    transitions = state.transitions
    assert_equal(transitions.length, 2, 'Wrong transition array.')
    assert_equal(transitions[0], 'T1', 'Wrong transition array.')
    assert_equal(transitions[1], 'T2', 'Wrong transition array.')
    assert_equal(state.verification, 'Verify(X, Y)', 'Wrong verification.')
    assert_equal(state.max_count, 1, 'Wrong max.')
  end

  def test_bad_max_count
    assert_raise do
      State.new(max_count: 1.1)
    end
  end

  def test_pick_transition
    t_list = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
    state = State.new(transitions: t_list)
    t_list.length.times do
      trans = state.pick_transition
      assert(t_list.include?(trans), "Transaction isn't in the list: #{trans} in #{t_list}")
    end
  end

  def test_max_count
    state = State.new(max_count: 3)
    assert(state.not_max?(2), 'Max_count not working')
    assert(!state.not_max?(3), 'Max_count not working')
  end
end
