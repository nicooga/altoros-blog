Why Coffeescript
----------------

**Disclamier:** This post intends to encourage a coding style (be read *preferences*) that *can make your life easier*. Some of these could make resemblance to certain languages that may or may not be of liking to -or even offend- some people. We come in peace, no offense intended. 

Javascript is the only choice we have in browser interpreted languages. Yet powerful, coding on plain JS syntax can become cumbersome, specially for those who come from OO languages like Ruby or Python. Coffescript addresses this problem with a transparent solution: a beautiful language that compiles to JS.

As I see it, CS is meant to let you do things the ruby way. That is, write less, do more.

### What do we gain?

More readability, less LOC, less pain. Lets iterate over some of it’s features.

  + Parenthesis(`()`) are optional.  
  + `->(){}` syntax:  
  **javascript:**

  ```javascript
    f = function() {
      return x(Math.pow(x, 3) + 4);
    }
  ```

  **coffeescript:**  

  ```coffeescript
  f = ->(x) Math.pow(x, 3) + 4
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
  **coffeescript:**

  ```coffeescript
    outer = 1
    changeNumbers = ->
      inner = -1
      outer = 10
    inner = changeNumbers()
  ```
  + Inline syntax for most language features:
    coffeescript:  
      person.sing() if person.happy
  + Array slicing with ranges. Note that this compiles to totally normal js:  
    **coffeescript:**

    ```coffeescript
      numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
      numbers[3..6] = [-3, -4, -5, -6]
    ```
    
    **javascript:**
    ```javascript
      var numbers, _ref;
      numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      [].splice.apply(numbers, [3, 4].concat(_ref = [-3, -4, -5, -6])), _ref;
    ```

  + `return`s are automatically pushed into each possible branch of execution, so your ruby:  
  **ruby:**

  ```ruby
    def greet # No superfluous returns needed
      "Good #{daytime == 'night' ? 'night' : 'day'}"
    end
  ```  
  becomes
  **coffeescript:** (yes! string interpolation supported)  
  ```coffeescript
    greet = -> "Good #{daytime is 'night' ? 'night' : 'day'}"
  ```  
