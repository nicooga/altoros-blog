The power of enumerators
========================

Ruby comes equipped with the `Enumerator` class, wich includes `Enumerable`.
This class comes in handy for a couple of things, but it's really good for generating
(possibly infinite) sequences.

A classic one, the Fibbonacci sequence, can be implemented like this:

```ruby
fib = Enumerator.new do |yielder|
  a, b = 1, 0
  loop do
    yielder.yield b
    a, b = b, a + b
  end
end

fib.next #=> 1
fib.next #=> 1
fib.next #=> 2
fib.next #=> 3
fib.next #=> 5

fib.rewind # use rewind to reset the sequencer
fib.next #=> 1
# and a bunch of methods for free!

fib.take_while { |i| i <= 100 }
=> [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]

fib.first(10)
=> [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]

fib.select(&:prime?) # Don't let ruby assume your enumerator is finite (if it isn't)
=> '*universe collapses*'
```

What about mathematical functions?

```ruby
class Quadratic < Enumerator
  # keyword arguments, new in ruby 2.0
  # check the links for more info
  def initialize(a=0,b=0,c=0, floor: 0, ceiling: Float::INFINITY)
    super() do |yielder|
      x = floor
      while x <= ceiling do
        yielder << a*x**2 + b*x + c
        x += 1
      end
    end
  end
end

q = Quadratic.new 1, 0, 0, floor: -10, ceiling: 10

q.next
=> 100
q.next
=> 81
q.each.with_index { |n, i| puts "f(#{i-10})= #{n}" }
=> [10000,
 6561,
 4096,
 2401,
 1296,
 625,
 256,
 81,
 16,
 1,
 0,
 1,
 16,
 81,
 256,
 625,
 1296,
 2401,
 4096,
 6561,
 10000]
```

Check more:

  + http://ruby-doc.org/core-2.0/Enumerator.html
  + http://blog.rubyhead.com/2013/02/26/ruby-2-0-getting-started-named-parameters/
