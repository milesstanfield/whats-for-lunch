require 'spec_helper'

describe 'edit restaurant page', type: :feature do
  let(:user){ FactoryGirl.create(:user) }
  before { create_restaurants_ratings(user) }
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

      it 'has a visit time field' do
        within 'form' do
          fill_in 'restaurant_last_visited', with: '01/04/2016'
        end
      end

      it 'has a be aware alert' do
        within 'form' do
          expect(page).to have_text 'BE AWARE:'
        end
      end

      describe 'update button' do
        it 'exists' do
          expect(page).to have_button 'Update Restaurant'
        end

        context 'on click' do
          before do
            fill_in 'restaurant_name', with: 'foo name'
            select '5', from: 'rating_value'
            fill_in 'restaurant_last_visited', with: '03/04/2016'
            click_button 'Update Restaurant'
          end

          context 'after updating record' do
            it 'redirects to show page' do
              expect(current_path).to eq "/restaurants/#{restaurant.id}"
            end

            it 'shows updated name' do
              expect(page).to have_text 'foo name'
            end

            it 'shows updated rating' do
              within '[name=\'data-row\']' do
                expect(page).to have_text '5 of 5'
              end
            end

            it 'shows updated visit time' do
              within '[name=\'data-row\']' do
                expect(page).to have_text '03/04/2016'
              end
            end
          end
        end
      end
    end
  end
end
