class HomeController < ApplicationController
  def index
    @body_color_class = 'm-bg-default'
    @restaurants = Restaurant.all
  end
end
