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

  def my_count(x = nil)
    total = 0
    for v in self 
      if x != nil
        total += 1 if v == x
      elsif block_given?
        total += 1 if yield v
      else
        total += 1
      end
    end
    total
  end

  def my_map(procc = nil)

    new_array = Array.new
    if block_given?
      for v in self
        new_array.push(yield v)
      end
    elsif procc != nil
      for v in self
        new_array.push(procc.call(v))
      end
    else
      return to_enum(:my_each_with_index)
    end
    new_array
  end

end

puts "my_map vs map"
numbers = [1,2,3,4,5]
p numbers.my_map {|value| value}
p numbers.map {|value| value}
p numbers.my_map {|value| value if value %2 == 0}
p numbers.map {|value| value if value %2 == 0}
p numbers.my_map
p numbers.map 
my_proc = Proc.new {|value|value}
p numbers.my_map(my_proc)
my_proc = Proc.new {|value| value if value %2 == 0}
p numbers.my_map(my_proc)
puts "\n\n"

