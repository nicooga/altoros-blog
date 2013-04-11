Objectifying the world
----------------------

In OOP we often face a choice: resolve problem x with classes or not.
Let me show you why *almost* always the answer is `class`.

### A random problem

Let's write a program to translate numeric literals from 1 to 1000 into words. 
To be concise I will follow the [british use for writing numerals](http://en.wikipedia.org/wiki/English_numerals).

#### First some premises

+ For numbers from 1 to 20 we have uniq numerals:

  ```ruby
    NUMERALS = {
      1 => 'one', 2 => 'two', 3 => 'three',
      4 => 'four', 5 => 'five', 6 => 'six',
      7 => 'seven', 8 => 'eight', 9 => 'nine',
      10 => 'ten', 11 => 'eleven', 12 => 'twelve',
      13 => 'thirdteen', 14 => 'fourteen', 15 => 'fifthteen',
      16 => 'sixteen', 17 => 'seventeen', 18 => 'eighteen',
      19 => 'nineteen', 20 => 'twenty'
    }
  ```

+ If the number is between 21 and 99 and the second digit is not zero we will write the number as two words separated by a hyphen.
As we know hot to write numbers from 1 to 9 we just need numerals for any number of two digits wich ends with zero:

  ```ruby
    NUMERALS = {
      #...
      20 => 'twenty',
      30 => 'thirty',
      40 => 'fourty',
      50 => 'fifty',
      60 => 'sixty',
      70 => 'seventy',
      80 => 'eighty',
      90 => 'ninety'
    }

+ All multiples of 100 are regular ('one hundred', 'two hundred', 'three hundred'...).
So we could make code like this:

  ```ruby
    def numeral_for(n)
      return NUMERALS[n] if NUMERALS[n]
      
      if (21..99) === n
        return NUMERALS[(n/10)*10] + '-' + NUMERALS[n%10]
      end

      if (100..999) === n
        str = NUMERALS[n/100] + ' hundred'
        str << ' and ' + NUMERALS[n%100/10*10] if NUMERALS[n%100/10*10]
        str << '-' + NUMERALS[n%100%10] if NUMERALS[n%100%10]
        return str
      end

      if n == 1000
        return 'one thousand'
      end
    end
  ```
It seems OK, but its buggy and maybe has an exceesivly large number of `if`s.
Let's what we can do to refactor this function.
It would be much more easier to work around if we decomposed numbers into 10 powers
and constructed it backwards. Then recursion simplifies things.

  ```ruby
    def numeral_for(n)
      return NUMERALS[n] if NUMERALS[n]
      h = n / 100
      t = n % 100 / 10
      u = n % 100 % 10

      str = h.zero? ? '' : numeral_for(h) + ' hundred'
    end
  ```