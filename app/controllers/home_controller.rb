class HomeController < ApplicationController
  def index
    @body_color_class = 'm-bg-default'
    @recommendations = Recommendations.fetch(restaurants)
  end

  private

  def restaurants
    query = Restaurant.limit(100)
    params[:day].present? ? query.days_old(params[:day]) : query
  end
end
