require 'average'
include Average

class Restaurant < ActiveRecord::Base
  has_many :ratings
  validates :name, uniqueness: true, presence: true
  scope :order_by_name, -> { order('name') }

  def user_rating(user)
    self.ratings.find_by_user_id_and_restaurant_id(user.id, self.id)
  end

  class << self
    def recommended
      fresh_restaurants = where('last_visited <= ?', 3.days.ago.strftime('%m/%d/%Y'))
      rated_restaurants = rate_restaurants(fresh_restaurants)
      order_subsets_by_time(rated_restaurants).sort_by {|k, v| k }.reverse.to_h
    end

    private

    def order_subsets_by_time(restaurants)
      restaurants.map do |groups|
        groups[1].sort_by! do |restaurant|
          TimeFormatter.parsed_visit_time(restaurant.last_visited).to_i
        end
        groups
      end.to_h
    end

    def average(restaurant)
      sum = restaurant.ratings.sum(:value)
      count = restaurant.ratings.count
      average = Average.find(sum, count)
      (average >= 5) ? 5 : average
    end

    def rate_restaurants(restaurants)
      restaurants.group_by {|restaurant| average(restaurant) }
    end
  end
end
