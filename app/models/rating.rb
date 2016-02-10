class Rating < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user

  def self.available_values
    [1, 2, 3, 4, 5]
  end

  def value_in_words
    "#{self.value} of 5"
  end
end
