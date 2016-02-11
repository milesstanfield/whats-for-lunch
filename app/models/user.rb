class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  has_many :ratings
end
