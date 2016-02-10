class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurants = Restaurant.where(user_id: current_user.id)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(restaurant_params)
      redirect_to @restaurant, flash: { message: 'Restaurant successfully updated!' }
    else
      redirect_to new_restaurant_path, flash: { errors: @restaurant.errors.full_messages }
    end
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to @restaurant, flash: { message: 'Restaurant successfully created!' }
    else
      redirect_to new_restaurant_path, flash: { errors: @restaurant.errors.full_messages }
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.destroy
      redirect_to restaurants_path, flash: { message: 'Restaurant successfully deleted!' }
    else
      redirect_to :back
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :user_id)
  end
end
