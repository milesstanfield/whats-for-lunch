require 'spec_helper'

describe 'new restaurant page', type: :feature do
  context 'when not logged in' do
    describe '/restaurants/new' do
      it 'redirects to login page' do
        visit '/restaurants/new'
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  context 'when logged in' do
    before do
      login FactoryGirl.create(:user)
      visit '/restaurants/new'
    end

    describe '/restaurants/new' do
      it 'has a header' do
        expect(page).to have_text 'New Restaurant'
      end

      it 'has a name field' do
        fill_in 'restaurant_name', with: 'Chick-fil-a'
      end

      it 'has a dropdown to select rating value' do
        select '1', from: 'rating_value'
      end

      it 'has a visit time field' do
        fill_in 'restaurant_last_visited', with: '01/04/2016'
      end

      it 'has a submit button' do
        expect(page).to have_button 'Create Restaurant'
      end

      context 'on successful form submission' do
        before(:each){ fill_and_submit_new_restaurant_form }

        it 'redirects to /restaurants/:id' do
          expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
        end

        it 'flashes a success message' do
          within '[name=\'flash-messages\']' do
            expect(page).to have_text 'Restaurant successfully created!'
          end
        end

        it 'has restaurant name' do
          expect(page).to have_text 'Chick-fil-a'
        end

        it 'has restaurant rating' do
          within '[name=\'data-row\']' do
            expect(page).to have_text '5 of 5'
          end
        end

        it 'has last visit time' do
          within '[name=\'data-row\']' do
            expect(page).to have_text '01/04/2016'
          end
        end
      end

      context 'on unsuccessful form submission' do
        before(:each){ fill_and_submit_new_restaurant_form(nil) }

        it 'refreshes the /restaurants/new page' do
          expect(current_path).to eq '/restaurants/new'
        end

        it 'flashes an error message' do
          within '[name=\'flash-errors\']' do
            expect(page).to have_text 'Name can\'t be blank'
          end
        end
      end
    end
  end
end
