class Restaurant < ActiveRecord::Base
  has_many :ratings
  validates :name, uniqueness: true, presence: true
end
