require 'spec_helper'

describe 'index restaurant page', type: :feature do
  context 'when not logged in' do
    describe '/restaurants' do
      it 'redirects to login page' do
        visit '/restaurants'
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  context 'when logged in' do
    before do
      user = FactoryGirl.create(:user)
      create_restaurants(user)
      FactoryGirl.create(:restaurant, name: 'unowned')
      login user
      visit '/restaurants'
    end

    describe '/restaurants' do
      it 'has a header' do
        expect(page).to have_text 'Your Restaurants'
      end

      describe 'data table' do
        it 'has users restaurants in recent order' do
          within rows.first do
            expect(page).to have_text 'newest'
          end

          within rows.last do
            expect(page).to have_text 'oldest'
          end
        end

        it 'doesnt have restaurants which arent owned by current user' do
          expect(page).not_to have_text 'unowned'
        end

        def rows
          page.all('[name=\'data-row\']')
        end

        xdescribe 'data rows' do
          it 'has restaurant name' do
            within first_row do
              expect(page).to have_text 'newest'
            end
          end

          it 'has users restaurant rating' do
            within first_row do
              expect(page).to have_text 'foo'
            end
          end

          it 'has community restaurant rating' do
            within first_row do
              expect(page).to have_text 'foo'
            end
          end

          xdescribe 'action links' do
          end

          def first_row
            page.first('[name=\'data-row\']')
          end
        end
      end
    end
  end
end
