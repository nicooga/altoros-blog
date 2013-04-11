Ruby, manipulating strings
==========================

Most languages has it's own idiosyncrasy for regular expressions, and so does Ruby.
There are a couple of gotchas you should be aware of.

Apart from classic metacharacters (`/./`, `/\w/`, `/\W/`, `/\d/`, `/\D/`, `/\h/`, `/\H/`, `/\s/`, `/\S/`) Ruby has some other shorthands:

  * `/[[:alnum:]]/`  - Alphabetic and numeric character
  * `/[[:alpha:]]/`  - Alphabetic character
  * `/[[:blank:]]/`  - Space or tab
  * `/[[:cntrl:]]/`  - Control character
  * `/[[:digit:]]/`  - Digit
  * `/[[:graph:]]/`  - Non-blank character (excludes spaces, control characters, and similar)
  * `/[[:lower:]]/`  - Lowercase alphabetical character
  * `/[[:print:]]/`  - Like [:graph:], but includes the space character
  * `/[[:punct:]]/`  - Punctuation character
  * `/[[:space:]]/`  - Whitespace character ([:blank:], newline, carriage return, etc.)
  * `/[[:upper:]]/`  - Uppercase alphabetical
  * `/[[:xdigit:]]/` - Digit allowed in a hexadecimal number (i.e., 0-9a-fA-F)
  * `/[[:word:]]/`   - A character in one of the following Unicode general categories Letter, Mark, Number, Connector_Punctuation
  * `/[[:ascii:]]/`  - A character in the ASCII character set

... and a bunch more. Check [Ruby Regexp](http://ruby-doc.org/core-1.9.3/Regexp.html) for more info.

**Named capture group notation** was also introduced in 1.9. With this feature you can keep complex regexps DRY without hacky interpolation:

  ```ruby
# Stolen from 'http://ruby.about.com/od/newinruby191/a/namedreg.htm'
  
users = %w{
  alice:10.23.52.112:true
  bob:192.168.10.34:false
}

user_regexp = %r{
  (?<username> [a-z]+){0}
  (?<ip_number> [0-9]{1,3}){0}
  (?<ip_address> (\g<ip_number>\.){3} \g<ip_number> ){0}
  (?<admin> true | false ){0}
  
  \g<username>:\g<ip_address>:\g<admin>
}x

users.map { |u| u.scan(user_regexp) }

=> [[["alice", "112", "10.23.52.112", "true"]],
 [["bob", "34", "192.168.10.34", "false"]]]
  ```
Accesing **named groups** is easy:

  ```ruby  
users.map { |u| u.scan(user_regexp) }

=> [[["alice", "112", "10.23.52.112", "true"]],
 [["bob", "34", "192.168.10.34", "false"]]]
 
users.map do |u|
  m = u.match(user_regexp)
  Hash[m.names.map(&:to_sym).zip(m.captures)]
end
=> [{:username=>"alice",
  :ip_number=>"112",
  :ip_address=>"10.23.52.112",
  :admin=>"true"},
 {:username=>"bob",
  :ip_number=>"34",
  :ip_address=>"192.168.10.34",
  :admin=>"false"}] # Ready for initialization!
  ```
**Replacement** can be handled via `String#gsub`:

  ```ruby
str = 'S4quee8ze1 a46l2257l the 0numbe71r0s to 0s687e62e 5me7618.'
str.gsub(/\d/, '')

=> "Squeeze all the numbers to see me."
  
str = 'HeLLo WoRld! ThIs CaSe seEms tO Be WroNG...'

str.gsub(/\w+/) do |w|
  if w =~ /wrong/i
    'Just Fine'
  else
    w[0].capitalize + w[1..-1].downcase
  end
end

=> "Hello World! This Case Seems To Be Just Fine..."
  ```
And there are also metacharacter for **unicode groups** from *Arabic* to *Yi*:

  ```ruby
str = 'HEY YOU, Вы, кажется, не в том месте парня.'

str.gsub(/\p{Cyrillic}+.*?\./u) do |m|
  s = '<translation>'
  s << EasyTranslate.translate(m, from: :russian, to: :english)
  s << '</translation>'
end
  ```
