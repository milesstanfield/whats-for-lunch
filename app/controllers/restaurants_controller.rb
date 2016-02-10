class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to @restaurant, flash: { message: 'Restaurant successfully created!' }
    else
      render :new
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.destroy
      redirect_to restaurants_path, flash: { message: 'Restaurant successfully deleted!' }
    else
      render :index
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end
end
