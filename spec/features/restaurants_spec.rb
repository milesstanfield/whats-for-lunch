require 'spec_helper'

describe 'restaurant admin pages', type: :feature do
  describe 'visit /restaurants/new' do
    before(:each){ visit '/restaurants/new' }

    it 'has a header' do
      expect(page).to have_text 'New Restaurant'
    end

    it 'has a name field' do
      fill_in 'restaurant_name', with: 'Chick-fil-a'
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
        within "[name='flash-messages']" do
          expect(page).to have_text 'Restaurant successfully created!'
        end
      end
    end

    context 'on unsuccessful form submission' do
      before(:each){ fill_and_submit_new_restaurant_form(nil) }

      it 'refreshes the /restaurants/new page' do
        expect(current_path).to eq '/restaurants/new'
      end

      it 'flashes an error message' do
        within "[name='flash-errors']" do
          expect(page).to have_text 'Name can\'t be blank'
        end
      end
    end
  end
end
