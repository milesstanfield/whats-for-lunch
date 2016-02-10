class Restaurant < ActiveRecord::Base
  has_many :ratings
  belongs_to :user
  validates :name, uniqueness: true, presence: true
  scope :recent, -> { order('created_at').reverse_order }

  def user_rating(user)
    self.ratings.find_by_user_id_and_restaurant_id(user.id, self.id)
  end
end
