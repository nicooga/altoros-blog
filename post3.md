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

Group notation was also introduced in 1.9. With this feature you can keep complex regexps DRY without hacky interpolation:

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
