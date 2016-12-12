require_relative '../lib/model'
require 'test/unit'

# Test the Transition class
class TestModel < Test::Unit::TestCase
  def setup
    s_list = [
      {
        state_name: 'Start',
        transtions: ['T1'],
        verification: nil,
        max_count: 1
      },
      {
        state_name: 'S1',
        transtions: ['T2', 'T3'],
        verification: 'started?()',
        max_count: 1
      },
      {
        state_name: 'S2',
        transtions: ['T4', 'T5'],
        verification: 'open?()',
        max_count: 0        
      },
      {
        state_name: 'End',
        transtions: [],
        verification: 'finished?()',
        max_count: 0        
      }
    ]
    t_list = [
      {
        transition_name: 'T1',
        source: 'Start',
        destionation: 'S1',
        action: 'get_started()',
        max_count: 0
      },
      {
        transition_name: 'T2',
        source: 'S1',
        destionation: 'End',
        action: 'cancel()',
        max_count: 0
      },
      {
        transition_name: 'T3',
        source: 'S1',
        destionation: 'S2',
        action: 'rolling()',
        max_count: 0
      },
      {
        transition_name: 'T4',
        source: 'S2',
        destionation: 'End',
        action: 'finish_up()',
        max_count: 0
      },
      {
        transition_name: 'T5',
        source: 'S2',
        destionation: 'S1',
        action: 'go_back()',
        max_count: 0
      }
    ]    
    @model = Model.new(s_list, t_list)
  end

  def test_create
    assert(not(@model.nil?), 'Model should not be nil.')
    assert_equal(4, @model.states.length, 'Wrong number of states.')
    assert_equal(5, @model.transitions.length, 'Wrong number of transitions.')
  end

  def test_get_indices
    assert_equal(0, @model.state_index('Start'), 'Wrong index for the start state.')
    assert_equal(3, @model.state_index('End'), 'Wrong index for the end state.')
    assert_equal(0, @model.trans_index('T1'), 'Wrong index for the first transition.')
  end

  # def test_query_transitions
  #   assert_equal()
  # end

end
