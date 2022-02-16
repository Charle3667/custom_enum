module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for a, b in self do
      yield a, b
    end
  end
end

puts "my_each vs each"
numbers = [1, 2, 3, 4, 5]
p numbers.my_each {|item| p item}
p numbers.each {|item| p item}
p numbers.my_each
p numbers.each
