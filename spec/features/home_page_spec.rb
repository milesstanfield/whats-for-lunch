require 'spec_helper'

describe 'home page', type: :feature do
  describe 'visit /' do
    before(:each){ visit '/' }

    describe 'log in link' do
      context 'when logged out' do
        it 'is on the page' do
          expect(page).to have_link 'Log in'
        end

        context 'on click' do
          before(:each){ click_link 'Log in' }

          it 'redirects to login path' do
            expect(current_path).to eq '/users/sign_in'
          end
        end
      end

      context 'when logged in' do
      end
    end


    describe 'logout link' do
      context 'when logged out' do
      end

      context 'when logged in' do
        before { FactoryGirl.create(:user) }
        before(:each){ login }

        it 'is on the page' do
          expect(page).to have_link 'Log out'
        end

        context 'on click' do
          before(:each){ click_link 'Log out' }

          it 'stays on the home page' do
            expect(current_path).to eq '/'
          end

          it 'displays log in link' do
            expect(page).to have_link 'Log in'
          end

          it 'hides log out link' do
            expect(page).not_to have_link 'Log out'
          end
        end
      end
    end


  end
end
