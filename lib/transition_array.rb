# Transitions array is tool to help pick available random transition
class TransitionArray
  def initialize(list)
    @sorted_list = []
    list.each do |item|
      @sorted_list << item
    end
    @sorted_list.sort!
    Random.new
  end

  def next
    trans_index = @sorted_list[Random.rand(@sorted_list.length)]
    @sorted_list.delete(trans_index)
    trans_index
  end

  def length
    return @sorted_list.length
  end

  def [](i)
    return @sorted_list[i]
  end
end
