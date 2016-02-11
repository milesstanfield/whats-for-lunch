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
    if @restaurant.update_attributes(restaurant_params) && update_rating!(@restaurant) && update_visit!(@restaurant)
      redirect_with_message @restaurant, 'updated'
    else
      redirect_with_error new_restaurant_path, @restaurant
    end
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save && save_rating!(@restaurant) && save_visit!(@restaurant)
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
    params.require(:restaurant).permit(:name, :user_id)
  end

  def rating_params
    params.require(:rating).permit(:value, :user_id)
  end

  def visit_params
    params.require(:visit).permit(:time, :user_id)
  end

  def rating
    Rating.new(rating_params)
  end

  def visit
    Visit.new params_with_time(visit_params)
  end

  def params_with_time(params)
    params[:time] = TimeFormatter.visit_time(Time.now) if params[:time].empty?
    params
  end

  def redirect_with_message(path, verb)
    redirect_to path, flash: { message: "Restaurant successfully #{verb}!" }
  end

  def redirect_with_error(path, record)
    redirect_to path, flash: { errors: record.errors.full_messages }
  end

  def save_rating!(restaurant)
    restaurant.ratings << rating
  end

  def save_visit!(restaurant)
    restaurant.visits << visit
  end

  def update_rating!(restaurant)
    restaurant.user_rating(current_user).update_attributes(rating_params)
  end

  def update_visit!(restaurant)
    restaurant.user_visit(current_user).update_attributes params_with_time(visit_params)
  end
end
