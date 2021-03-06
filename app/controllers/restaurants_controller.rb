class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurants = Restaurant.limit(100)
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
    if @restaurant.update_attributes(restaurant_params) && save_rating!(@restaurant)
      redirect_with_message @restaurant, 'updated'
    else
      redirect_with_error new_restaurant_path, @restaurant
    end
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save && save_rating!(@restaurant)
      redirect_with_message @restaurant, 'created'
    else
      redirect_with_error new_restaurant_path, @restaurant
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.destroy
      redirect_with_message restaurants_path, 'deleted'
    else
      redirect_to :back
    end
  end

  private

  def restaurant_params
    params_with_time params.require(:restaurant).permit(:name, :last_visited)
  end

  def rating_params
    params.require(:rating).permit(:value, :user_id)
  end

  def params_with_time(params)
    params[:last_visited] = TimeFormatter.visit_time(Time.now) if params[:last_visited].empty?
    params
  end

  def redirect_with_message(path, verb)
    redirect_to path, flash: { message: "Restaurant successfully #{verb}!" }
  end

  def redirect_with_error(path, record)
    redirect_to path, flash: { errors: record.errors.full_messages }
  end

  def save_rating!(restaurant)
    user_rating = restaurant.user_rating(current_user)
    if user_rating
      user_rating.update_attributes(rating_params)
    else
      restaurant.ratings << Rating.new(rating_params)
    end
  end
end
