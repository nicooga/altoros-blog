Why Coffeescript
----------------

**Disclamier:** This post intends to encourage a coding style (be read *preferences*) that *can make your life easier*. Some of these could make resemblance to certain languages that may or may not be of liking to -or even offend- [some people](http://oscargodson.com/posts/why-i-dont-use-coffeescript.html). We come in peace, no offense intended. 

Javascript is the only choice we have in browser interpreted languages. Yet powerful, coding on plain JS syntax can become cumbersome, specially for those who come from OO languages like Ruby or Python. Coffescript addresses this problem with a transparent solution: a beautiful language that compiles to JS.

As I see it, CS is meant to let you do things the ruby way. That is, write less, do more.

### What do we gain?

More readability, less LOC, less pain. Lets iterate over some of it’s features.

  + Parenthesis(`()`) are optional.  
  + `(...)->` syntax:  
  **javascript:**

  ```javascript
    f = function(x) {
      return (Math.pow(x, 3) + 4);
    }
  ```

  **coffeescript:**  

  ```coffeescript
  f = (x)-> Math.pow(x, 3) + 4
  ```  
  + Code blocks are infered from indentation, there's a lot of flexibility for passing arguments. This can be appreciatted much more when working with complex argument list that could take functions as parameters. Real life example:  
  **javascript:**

  ```javascript
    $('#query_form a').on('click', function() {
      var $query;
      $query = $(this).parent().find('input[name="query"]').val();
      if ($query === "") {
        return alert("NO ò_ò");
      }
      return $.get("/posts/query", {
        query: $query
      }, function(data) {
        return $.each(data.json, function() {
          var $link;
          $link = $('<a>').attr({
            href: "posts/show/" + this.id,
            "class": 'act'
          }).html(this.title);
          $query_container.append($('<p>').html($link));
          return $query_container.append($('<p>').html(this.body));
        });
      });
    });
  ```

  **coffeescript:**
  
  ```coffeescript
    $('#query_form a').on 'click', ->
      $query = $(this).parent().find('input[name="query"]').val()
      return alert "NO ò_ò" if $query is ""
      $.get "/posts/query", query: $query, (data) ->
        $.each data.json, ->
          $link = $('<a>').attr(
            href: "posts/show/#{@id}"
            class: 'act').html @title
          $query_container.append $('<p>').html $link
          $query_container.append $('<p>').html @body
  ```
  Trying to debug last piece of code at plain sight can murder your eyes. Miss a single bracket and you are done for. Although LOC doesn't seem to get too low in this example, readability can save precious minutes -or even hours- of your time.
  + Compiler takes care of lexical scope. No more `var` declarations. `return` keywords are also optional.  

  ```coffeescript
    outer = 1
    changeNumbers = ->
      inner = -1
      outer = 10
    inner = changeNumbers()
  ```
  + Inline syntax for most language features:
    coffeescript:  

  ```coffescript
    person.sing() if person.happy
  ```

  + `return`s are automatically pushed into each possible branch of execution, so your ruby:  

  ```ruby
    def greet # No superfluous returns needed
      hs = Time.now.strftime("%k")
      "Good #{hs === 6..19 ? 'night' : 'day'}"
    end
  ```  
  becomes
  **coffeescript:** (yes! string interpolation supported)  
  ```coffeescript
    greet = ->
      hs = (new Date()).getHours
      "Good #{(hs in [6..19]) ? 'day' : 'night'}"
      
    alert greet()
  ```  

It would be redundant to mention all coffeescript features here. Check [Coffeescript.org](http://coffeescript.org/) for more info on it's goodies, or have fun convertig your JS into coffee and see what it is like [here](http://js2coffee.org/).
Now the real question is, should you use CS? You surely have found a variety of feedback about why or why not use CS.
All these people have (more or less) equally valid arguemnts but I'd like to emphasize one:

Maggie Longshore commented on [A case against coffescript](http://ryanflorence.com/2011/case-against-coffeescript/)
> Substitute C for CS and Assembler for JS and then these arguments remind me of when Assembler programmers where starting to use C to write programs, C was much faster to write and easier to read, We knew Assembler inside and out. At the time the debugging had to be done at the assembly level (embedded systems).  So we had to debug in assembler code that we had not written if we wrote the programs in C or we could write and debug the entire application in Assembler.  Fortunately we had source code listings with C and assembler along with the mapped addresses to ease stepping into code and writing patches on the fly for testing.  
> Writing in C was less error-prone and much less time had to be spent debugging, we were much more productive in C. The tooling got better and there was no looking back.  
> I don't know if CS will survive or not but if developers are productive in it then the tooling and debug story can be improved with time.  

In any case, if you are new to Javascript, I'd suggest not to jump on coffee until you got the basics covered or -as many other people pointed- you'll get all wrong.
In the end Coffescript is another way of writting Javascript, and (I hope) a better one.
