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
  end

  describe '.days_old(day)' do
    before do
      older = FactoryGirl.create(:restaurant, name: 'older', last_visited: '02/03/2016')
      newer = FactoryGirl.create(:restaurant, name: 'newer', last_visited: '02/09/2016')
    end

    it 'returns all orders that fall within a given day range' do
      time = TimeFormatter.parsed_visit_time('02/11/2016')
      expect(Restaurant.days_old(3, time).find_by_name('older')).to be_present
      expect(Restaurant.days_old(3, time).find_by_name('newer')).not_to be_present
    end
  end
end
