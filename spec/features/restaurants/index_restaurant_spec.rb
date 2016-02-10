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
      create_restaurants_and_ratings(user)
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

        describe 'data rows' do
          let(:restaurant){ Restaurant.find_by_name('newest') }

          it 'has restaurant name' do
            within rows.first do
              expect(page).to have_text 'newest'
            end
          end

          it 'has users restaurant rating' do
            within rows.first do
              expect(page).to have_text '1 of 5'
            end
          end

          describe 'action links' do
            describe 'view link' do
              it 'exists' do
                within rows.first do
                  expect(page).to have_link 'view'
                end
              end

              context 'on click' do
                it 'redirects to show page' do
                  within rows.first do
                    click_link 'view'
                    expect(current_path).to eq "/restaurants/#{restaurant.id}"
                  end
                end
              end
            end

            describe 'edit link' do
              it 'exists' do
                within rows.first do
                  expect(page).to have_link 'edit'
                end
              end

              context 'on click' do
                it 'redirects to edit page' do
                  within rows.first do
                    click_link 'edit'
                    expect(current_path).to eq "/restaurants/#{restaurant.id}/edit"
                  end
                end
              end
            end

            describe 'delete link' do
              it 'exists' do
                within rows.first do
                  expect(page).to have_link 'delete'
                end
              end

              context 'on click' do
                it 'redirects to index page' do
                  within rows.first do
                    click_link 'delete'
                    expect(current_path).to eq '/restaurants'
                  end
                end

                it 'removes record' do
                  within rows.first do
                    click_link 'delete'
                  end
                  expect(Restaurant.find_by_name('newest')).not_to be_present
                end
              end
            end
          end
        end

        def rows
          page.all('[name=\'data-row\']')
        end
      end
    end
  end
end
