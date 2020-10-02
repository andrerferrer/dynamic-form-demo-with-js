# GOAL

This is a demo to show-case how to implement the creation of several models (of the same type) in a single form using a bit of async javascript.

[You can also check my other demos](https://github.com/andrerferrer/dedemos/blob/master/README.md#ded%C3%A9mos).

This demo was created from [another one](https://github.com/andrerferrer/dynamic-form-demo).

## What needs to be done?

### 1. Adjust the Controller

In the `app/controllers/restaurants_controller.rb`:

```ruby
class RestaurantsController < ApplicationController
  def new
    @restaurants = [
      Restaurant.new
    ]
    
    respond_to do |format|
      format.html
      format.js
    end
  end
end
```

### 2. Adjust the View

Add the ➕ link to `app/views/restaurants/new.html.erb`:

```erb
<div class="container">

  <%= simple_form_for :restaurants, url: restaurants_path do |f| %>
    
    <% @restaurants.each do |restaurant| %>
      <%= f.simple_fields_for "", restaurant do |g| %>
        <%= g.input :name, input_html: { value: restaurant.name } %>
        <%= g.input :address, input_html: { value: restaurant.address } %>
      <% end %>
    <% end %>
    <p>
      <%= link_to '➕', new_restaurant_path, remote: true, id: "new-restaurant-form-btn" %>
    </p>
    <%= f.submit %>
  <% end %>

</div>
```

### 3. Adjust the Response
In the `app/views/restaurants/new.js.erb`:

```js
document.getElementById('new-restaurant-form-btn')
        .insertAdjacentHTML('beforebegin', `
          <%= render 'restaurants/partials/restaurant_form', restaurant: Restaurant.new %>
        `)

```

### 4. Adjust the Partial that will be used in the response
In the `app/views/restaurants/partials/_restaurant_form.html.erb`: 

```erb
<%= simple_fields_for "restaurants[]", restaurant do |f| %>
  <%= f.input :name, input_html: { value: restaurant.name } %>
  <%= f.input :address, input_html: { value: restaurant.address } %>
<% end %>
```


And we're good to go 🤓

Good Luck and Have Fun
