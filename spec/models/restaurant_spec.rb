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
    before(:each) { create_multi_user_restaurants }

    describe '.order_by_name' do
      it 'orders restaurants by their name' do
        expect(Restaurant.order_by_name.map(&:name)).to eq ['ancient', 'newest', 'older', 'oldest']
      end
    end

    describe '.recommended' do
      it 'orders restaurants by their cumulative ratings' do
        Restaurant.recommended.each_with_index do |recommendation, index|
          expect(recommendation[0]).to eq 3 if index == 0
          expect(recommendation[0]).to eq 2 if index == 1
        end
      end

      it 'filters restaurants by their last_visited date (3 days new are removed)' do
        newest = Restaurant.find_by_name('newest')
        newest_is_in_collection = Restaurant.recommended.any? do |recommendation|
          recommendation[1].any? {|restaurant| restaurant == newest }
        end
        expect(newest_is_in_collection).to be false
      end

      it 'orders subsets of restaurants with same ratings by their date' do
        Restaurant.recommended.each_with_index do |recommendation, index|
          if index == 1
            expect(recommendation[1].first.name).to eq 'ancient'
            expect(recommendation[1].last.name).to eq 'oldest'
          end
        end
      end
    end
  end
end
