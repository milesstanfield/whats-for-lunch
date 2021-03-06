class Restaurant < ActiveRecord::Base
  has_many :ratings
  validates :name, uniqueness: true, presence: true
  scope :order_by_name, -> { order('name') }

  def user_rating(user)
    self.ratings.find_by_user_id_and_restaurant_id(user.id, self.id)
  end

  def self.days_old(day, time = Time.now)
    visit_time = TimeFormatter.visit_time(time - day.to_i.days)
    where('last_visited <= ?', visit_time)
  end
end
