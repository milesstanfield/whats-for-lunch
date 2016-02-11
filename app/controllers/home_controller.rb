class HomeController < ApplicationController
  def index
    @body_color_class = 'm-bg-default'
    @recommendations = Restaurant.limit(100).recommended
  end
end
