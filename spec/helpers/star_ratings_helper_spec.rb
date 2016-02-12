require 'spec_helper'

describe StarRatingsHelper, type: :helper do
  describe '.star_states' do
    context 'when average_rating == 1' do
      it 'returns formatted options for star ratings' do
        expect(star_states(1)).to eq [false, false, false, false, true]
      end
    end

    context 'when average_rating == 3' do
      it 'returns formatted options for star ratings' do
        expect(star_states(3)).to eq [false, false, true, true, true]
      end
    end

    context 'when average_rating == 10' do
      it 'returns formatted options for star ratings' do
        expect(star_states(10)).to eq [true, true, true, true, true]
      end
    end
  end

  describe 'star_data(*)' do
    let(:user){ FactoryGirl.create(:user) }
    let(:restaurant){ FactoryGirl.create(:restaurant) }
    before do
      restaurant.ratings << FactoryGirl.create(:rating, value: 5, user_id: user.id)
    end
    let(:hash){ star_data(false, 0, user, restaurant, true) }

    describe 'returned hash' do
      it 'has type' do
        expect(hash[:type]).to eq 'star'
      end

      it 'has class' do
        expect(hash[:class]).to eq 'star-voted'
      end

      describe 'data object' do
        it 'has a name' do
          expect(hash[:data][:name]).to eq 'Chick-fi-a'
        end

        it 'has last_visited' do
          expect(hash[:data][:last_visited]).to eq nil
        end

        it 'has user_id' do
          expect(hash[:data][:user_id]).to eq user.id
        end

        it 'has id' do
          expect(hash[:data][:id]).to eq restaurant.id
        end

        it 'has action' do
          expect(hash[:data][:action]).to eq 'update'
        end
      end
    end
  end
end
