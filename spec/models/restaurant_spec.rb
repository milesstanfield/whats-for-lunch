require 'spec_helper'

describe Restaurant do
  subject(:restaurant){ FactoryGirl.create(:restaurant) }
  let(:user){ FactoryGirl.create(:user) }

  describe 'attributes' do
    it_has_attributes 'name', 'last_visited'
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

  describe 'create_restaurants_ratingsating(user)' do
    it 'gets restaurant rating record from given user' do
      rating = FactoryGirl.create(:rating, user_id: user.id, value: 3)
      restaurant.ratings << rating
      expect(restaurant.user_rating(user)).to eq rating
    end
  end

  describe 'scopes' do
    before { create_multi_user_restaurants }

    describe '.order_by_name' do
      it 'orders restaurants by their name' do
        expect(Restaurant.order_by_name.map(&:name)).to eq ['ancient', 'newest', 'older', 'oldest']
      end
    end

    describe '.by_day(day)' do
      it 'returns all orders that fall within a given day range' do
        expect(Restaurant.by_day(3).find_by_name('newest')).to be nil
      end
    end
  end
end
