AJAX on Rails
=============

As a live demo of what coding CoffeeScript feels like this little tutorial covers the basics of AJAX and Rails.
This time I'll use a classic app: a microblogging app for posts, and an asynchronous voting feature for them.

```bash
$ rm public/index.html
$ rake db:create
$ rails g resource post title:string name:string votes:integer
$ rake db:migrate
```
We can begin to work with this basic scaffold. There are multiple of going about votes; you may choose to create another model for votes in order to keep track of what a user has voted, being able to remove your vote, limit the times a user can vote in the same post, etc. But I'll use the simpler way, a integer column *votes* on *Posts* table. I'd recommended using [`ActiveRecord::Counter`](http://api.rubyonrails.org/classes/ActiveRecord/CounterCache.html) for updating the `votes` field.

```ruby
class PostsController < ApplicationController
  respond_to :html, :json

  def index
    respond_with @posts = Post.all
  end

  def vote_up
    @post = Post.find(params[:id])
    if @post.increment! :votes
      respond_with @post do |format|
        format.html { redirect :back }
      end
    end
  end
end
```

We'll need to add some routes before:

```ruby
# config/routes.rb
MyBloggingApp::Application.routes.draw do
  root to: 'posts#index'
  resources :posts do
    member { post :vote_up }
  end
end
```

A js (coffescript) snippet for the vote up button and we should be good to go.

```coffeescript
$ ->
  $('.post a.vote_up').click (ev)->
    ev.stopImmediatePropagation()
    ev.preventDefault() # If the javascript is enabled prevent default event (navigation)
    id = @id
    $.ajax
      url: "/posts/#{id}/vote_up.json",
      type: 'POST',
      complete: (data)-> # Update the 'Votes: X' field on success 
        post = JSON.parse(data.responseText)
        $("small##{id}_votes").text("Votes: #{post.votes}")
```

The source code for this app is [here]() if you want to take a closer look.

More info
---------

[jQuery.ajax() docs](https://www.google.com.ar/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&ved=0CCcQFjAA&url=http%3A%2F%2Fapi.jquery.com%2FjQuery.ajax%2F&ei=vGe7UZP_LunXygHeqIDACQ&usg=AFQjCNF1ITsE5bJBc65MY4nqhZq7OkHZpg&sig2=ESiYWB05iEkIRUBFjaKzPQ)  
[David Parker's blog post on Rails `respond_to`](http://davidwparker.com/2010/03/09/api-in-rails-respond-to-and-respond-with/)