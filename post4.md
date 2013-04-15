The power of enumerators
========================

Ruby comes equipped with the `Enumerable` class, wich includes `Enumerable`.
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

A quick example with finite sequences

```ruby
  
```