require 'spec_helper'

describe 'edit restaurant page', type: :feature do
  let(:user){ FactoryGirl.create(:user) }
  before { create_restaurants_and_ratings(user) }
  let(:restaurant){ Restaurant.find_by_name('newest') }

  context 'when not logged in' do
    describe '/restaurants/:id/edit' do
      it 'redirects to login page' do
        visit "/restaurants/#{restaurant.id}/edit"
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  context 'when logged in' do
    before do
      login user
      visit "/restaurants/#{restaurant.id}/edit"
    end

    describe '/restaurants/:id/edit' do
      it 'has a header' do
        expect(page).to have_text 'Edit Restaurant'
      end

      it 'has a name field' do
        within 'form' do
          expect(page).to have_css "input[type='text'][placeholder='#{restaurant.name}']"
        end
      end

      describe 'update button' do
        it 'exists' do
          expect(page).to have_button 'Update Restaurant'
        end

        context 'on click' do
          it 'redirects to show page' do
            click_button 'Update Restaurant'
            expect(current_path).to eq "/restaurants/#{restaurant.id}"
          end

          it 'updates record' do
            expect(Restaurant.find_by_name('foo name')).not_to be_present
            fill_in 'restaurant_name', with: 'foo name'
            click_button 'Update Restaurant'
            expect(Restaurant.find_by_name('foo name')).to be_present
          end
        end
      end
    end
  end
end
