class Restaurant < ActiveRecord::Base
  has_many :ratings
  validates :name, uniqueness: true, presence: true
  scope :order_by_name, -> { order('name') }

  def user_rating(user)
    self.ratings.find_by_user_id_and_restaurant_id(user.id, self.id)
  end

  def self.recommended
    fresh_restaurants = where('last_visited <= ?', 3.days.ago.strftime('%m/%d/%Y'))
    rated_restaurants = fresh_restaurants.group_by {|restaurant| restaurant.ratings.sum(:value) }
    rated_restaurants.sort_by {|k, v| k }.reverse.to_h
  end
end
