require 'spec_helper'

describe 'login page', type: :feature do
  describe 'visit /users/sign_in' do
    before(:each){ visit '/users/sign_in' }

    describe 'form' do
      it 'has an email field' do
        fill_in 'user_email', with: 'user@example.com'
      end

      it 'has a password field' do
        fill_in 'user_password', with: 'password'
      end

      it 'has a log in button' do
        within 'form' do
          expect(page).to have_button 'Log in'
        end
      end

      context 'on succcessful login' do
        before { FactoryGirl.create(:user) }
        before(:each){ login }

        it 'redirects to home page' do
          expect(current_path).to eq '/'
        end
      end

      context 'on unsuccessful login' do
        before(:each){ login('non_existant_user@example.com', 'password') }

        it 'stays on the login page' do
          expect(current_path).to eq '/users/sign_in'
        end
      end
    end
  end
end
