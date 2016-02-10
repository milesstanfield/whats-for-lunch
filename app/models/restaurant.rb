class Restaurant < ActiveRecord::Base
  has_many :ratings
  validates :name, uniqueness: true, presence: true
  scope :recent, -> { order('created_at').reverse_order }
end
