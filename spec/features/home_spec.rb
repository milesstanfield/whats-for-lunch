require 'spec_helper'

describe 'home', type: :feature do
  describe 'visit /' do
    before { create_multi_user_restaurants(Time.now) }
    before(:each){ visit '/' }

    describe 'cards' do
      it 'has restaurant name' do
        within cards.first do
          expect(page).to have_text 'ancient'
        end
      end

      it 'has days since last visit' do
        within cards.first do
          expect(page).to have_text '3'
        end
      end

      it 'has (x) amount of community rated stars' do
        within cards.first do
          selected_stars = page.all('.star-selected')
          expect(selected_stars.count).to eq 2
        end
      end

      context 'first card' do
        it 'has #1 pick mark' do
          within cards.first do
            expect(page).to have_css '.card-bookmark'
            expect(page).to have_text '#1 pick'
          end
        end
      end

      context 'last card' do
        it 'has an add new icon' do
          within cards.last do
            expect(page).to have_css '.fa-plus'
          end
        end

        context 'on click' do
          it 'redirects to ' do
            within cards.last do
              page.first('a').click
            end
          end
        end
      end
    end

    describe 'sub_nav' do
      describe 'recommended link' do
        it 'exists' do
          within sub_nav do
            expect(page).to have_link 'Recommended'
          end
        end

        context 'on click' do
          it 'redirects to home path' do
            expect(current_path).to eq '/'
          end
        end
      end

      describe 'day filters' do
        it 'exists' do
          within sub_nav do
            expect(page).to have_button 'Last Visited'
            expect(page).to have_link 'at least 3 days ago'
          end
        end

        context 'on click' do
          it 'redirects to home page with filter param' do
            within sub_nav do
              click_button 'Last Visited'
              click_link 'at least 3 days ago'
              expect(current_url).to include '/?day=3'
            end
          end
        end
      end
    end
  end

  def cards
    page.all('[name=\'card\']')
  end

  def sub_nav
    '[name=\'sub-nav\']'
  end
end
