require_relative '../lib/state'
require 'test/unit'

# Test the State class
class TestState < Test::Unit::TestCase
  def test_defaults
    state = State.new
    assert_equal('Start', state.current_name, 'Wrong name.')
    assert_equal(1, state.transition_array.length, 'Wrong transition array.')
    assert_equal('Verify(X)', state.code, 'Wrong code.')
    assert_equal(0, state.max_count, 'Wrong max.')
  end

  def test_non_defaults
    state = State.new(current_name: 'MyStart',
                      transitions: ['T1', 'T2'],
                      code: 'Verify(X, Y)',
                      max_count: 1)
    assert_equal('MyStart', state.current_name, 'Wrong name.')
    assert_equal(2, state.transition_array.length, 'Wrong transition array.')
    assert_equal('T1', state.transition_array[0], 'Wrong transition array.')
    assert_equal('Verify(X, Y)', state.code, 'Wrong code.')
    assert_equal(1, state.max_count, 'Wrong max.')
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
      trans = state.next_transition
      assert(t_list.include?(trans), "Transaction isn't in the list: #{trans} in #{t_list}")
    end
  end

  def test_max_count
    state = State.new(max_count: 3)
    assert(state.not_max?(2), 'Max_count not working')
    assert(!state.not_max?(3), 'Max_count not working')
  end
end
