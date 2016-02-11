class Restaurant < ActiveRecord::Base
  has_many :ratings
  validates :name, uniqueness: true, presence: true
  scope :order_by_name, -> { order('name') }

  def user_rating(user)
    self.ratings.find_by_user_id_and_restaurant_id(user.id, self.id)
  end

  def self.by_day(day)
    where('last_visited <= ?', day.to_i.days.ago.strftime('%m/%d/%Y'))
  end
end
