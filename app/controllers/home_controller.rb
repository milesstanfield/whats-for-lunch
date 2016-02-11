class HomeController < ApplicationController
  def index
    @body_color_class = 'm-bg-default'
    @recommendations = Recommendations.fetch Restaurant.limit(100)
  end
end
