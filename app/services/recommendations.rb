require 'average'
include Average

class Recommendations
  class << self
    def fetch(restaurants)
      fresh_restaurants = restaurants.days_old(3)
      rated_restaurants = rate_restaurants(fresh_restaurants)
      reverse_hash sort_subsets_by_time(rated_restaurants)
    end

    private

    def sort_subsets_by_time(restaurants)
      restaurants.map {|groups| sort_subsets!(groups) ; groups}.to_h
    end

    def rate_restaurants(restaurants)
      restaurants.group_by {|restaurant| average(restaurant) }
    end

    def reverse_hash(hash)
      hash.sort_by {|k, v| k }.reverse.to_h
    end

    def sort_subsets!(groups)
      groups[1].sort_by! do |restaurant|
        TimeFormatter.parsed_visit_time(restaurant.last_visited).to_i
      end
    end

    def average(restaurant)
      sum = restaurant.ratings.sum(:value)
      count = restaurant.ratings.count
      average = Average.find(sum, count)
      (average >= 5) ? 5 : average
    end
  end
end
