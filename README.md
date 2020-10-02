# GOAL

This is a demo to show-case how to implement the creation of several models (of the same type) in a single form.

[You can also check my other demos](https://github.com/andrerferrer/dedemos/blob/master/README.md#ded%C3%A9mos).

## What needs to be done?

### 1. Adjust the view
```erb
<div class="container">

  <%= simple_form_for :restaurants, url: restaurants_path do |f| %>
    
    <% @restaurants.each do |restaurant| %>
      <%= f.simple_fields_for "", restaurant do |g| %>
        <%= g.input :name, input_html: { value: restaurant.name } %>
        <%= g.input :address, input_html: { value: restaurant.address } %>
      <% end %>
    <% end %>
    

    <%= f.submit %>
  <% end %>

</div>
```


### 2. Adjust the controller
```ruby
class RestaurantsController < ApplicationController
  def new
    @restaurants = [Restaurant.new, Restaurant.new]
  end

  def create
    restaurants_data = strong_params
    @restaurants = Restaurant.create(restaurants_data)
    @restaurants = @restaurants.filter { |restaurant| restaurant.errors.any? }

    if @restaurants.empty?
      redirect_to restaurants_path, alert: "All restaurants where correctly created!"
    else
      # check if any restaurants were saved and show the according message
      if @restaurants.count != restaurants_data.count
        flash[:alert] = "Some restaurants were saved! You should check in on some of the fields below."
      else
        flash[:alert] = "You should check in on some of the fields below."
      end
      
      render :new
    end

  end

  private

  def strong_params
    params.require(:restaurants).map { |param| param.permit(Restaurant::STRONG_PARAMS) }
  end
end

```

## Inspiration

I drew inspiration from [this medium article](https://medium.com/@jhcheung/using-fields-for-to-edit-multiple-records-without-a-parent-record-818b8d0e98a3).

And we're good to go 🤓

Good Luck and Have Fun
