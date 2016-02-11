require 'spec_helper'

describe 'show restaurant page', type: :feature do
  let(:user){ FactoryGirl.create(:user) }
  before { create_restaurants_ratings(user) }
  let(:restaurant){ Restaurant.find_by_name('newest') }

  context 'when not logged in' do
    describe '/restaurants/:id' do
      it 'redirects to login page' do
        visit "/restaurants/#{restaurant.id}"
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  context 'when logged in' do
    before do
      login user
      visit "/restaurants/#{restaurant.id}"
    end

    describe '/restaurants/:id' do
      it 'has a name header' do
        expect(page).to have_text 'newest'
      end

      it 'has a rating' do
        within '[name=\'data-row\']' do
          expect(page).to have_text '1 of 5'
        end
      end

      describe 'edit button' do
        it 'exists' do
          expect(page).to have_button 'edit'
        end

        context 'on click' do
          it 'redirects to edit page' do
            click_button 'edit'
            expect(current_path).to eq "/restaurants/#{restaurant.id}"
          end
        end
      end

      describe 'delete button' do
        it 'exists' do
          expect(page).to have_button 'delete'
        end

        context 'on click' do
          it 'redirects to index page' do
            click_link 'delete'
            expect(current_path).to eq '/restaurants'
          end

          it 'removes record' do
            click_link 'delete'
            expect(Restaurant.find_by_name('newest')).not_to be_present
          end
        end
      end
    end
  end
end
