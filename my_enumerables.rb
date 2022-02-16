module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for a, b in self do
      yield a, b
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    for i in 0..self.size-1 do
      yield self[i], i
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    selected_array = []
    selected_hash = {}
    if self.is_a?(Array)
      for v in self
        selected_array.push(v) if yield v
      end
      selected_array
    else
      for k, v in self
        selected_hash[k] = v if yield k, v
      end
      selected_hash
    end
  end

  def my_all?(x = nil)

    bool = true
    for v in self
      if x != nil
        bool = false unless x === v
      elsif block_given?
        bool = false unless yield v
      else
        return to_enum(:my_select)
      end
    end
    bool
  end

  def my_none?(x = nil)
    bool = true
    for v in self
      if x != nil
        bool = false if x === v
      elsif block_given?
        bool = false if yield v
      else
        bool = false if v
      end
    end
    bool
  end
end

puts "my_none? vs none?"
numbers = [1,2,3,4,5]
wrong_numbers = [1,3,5,7,9]
p numbers.my_none? {|value| value %2 == 0}
p numbers.none? {|value| value %2 == 0}
p wrong_numbers.my_none? {|value| value %2 == 0}
p wrong_numbers.none? {|value| value %2 == 0}
p [].my_none?
p [].none?
p [nil, true].my_none?
p [nil, true].none?
p [].my_none?(Float)
p [].none?(Float)
puts "\n\n"

