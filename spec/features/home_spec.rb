require 'spec_helper'

describe 'home', type: :feature do
  describe 'visit /' do
    before { create_multi_user_restaurants }
    before(:each){ visit '/' }

    describe 'cards' do
      it 'has restaurant name' do
        within first_card do
          expect(page).to have_text 'older'
        end
      end

      it 'has days since last visit' do
        within first_card do
          expect(page).to have_text '3'
        end
      end

      it 'has (x) amount of community rated stars' do
        within first_card do
          selected_stars = page.all('.star-selected')
          expect(selected_stars.count).to eq 3
        end
      end

      context 'first card' do
        it 'has #1 pick mark' do
          within first_card do
            expect(page).to have_css '.card-bookmark'
            expect(page).to have_text '#1 pick'
          end
        end
      end
    end
  end

  def first_card
    page.first('[name=\'card\']')
  end
end
