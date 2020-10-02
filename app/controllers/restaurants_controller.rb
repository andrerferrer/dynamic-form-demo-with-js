class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    set_restaurant
    @review = Review.new
  end

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

  def destroy
    set_restaurant
    @restaurant.destroy
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def strong_params
    params.require(:restaurants).map { |param| param.permit(Restaurant::STRONG_PARAMS) }
  end
end
