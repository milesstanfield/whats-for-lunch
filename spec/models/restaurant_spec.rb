require 'spec_helper'

describe Restaurant do
  subject(:restaurant){ FactoryGirl.create(:restaurant) }

  describe 'attributes' do
    it_has_attributes 'name', 'user_id'
  end

  describe 'associations' do
    it 'has many ratings' do
      expect(restaurant.ratings).to eq []
    end
  end

  describe 'validations' do
    it 'requires a name' do
      expect{FactoryGirl.create(:restaurant, name: nil)}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'must have a unique name' do
      FactoryGirl.create(:restaurant)
      expect{FactoryGirl.create(:restaurant)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe '.recent' do
    it 'sorts by recently created' do
      create_restaurants
      expect(Restaurant.recent.map(&:name)).to eq ['newest', 'older', 'oldest']
    end
  end

  describe '.user_rating(user)' do
    it 'gets restaurant rating record from given user' do
      user = FactoryGirl.create(:user)
      user.restaurants << restaurant
      rating = FactoryGirl.create(:rating, user_id: user.id, value: 123)
      restaurant.ratings << rating
      expect(restaurant.user_rating(user)).to eq rating
    end
  end
end
