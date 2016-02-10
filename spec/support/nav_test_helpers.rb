module NavTestHelpers
  def nav_expectations(destination)
    let(:user){ FactoryGirl.create(:user) }
    before(:each){ create_path_from_destination!(destination, user) }

    describe @path do
      before { visit @path }

      context 'when logged out' do
        it 'has a nav' do
          expect(page).to have_css 'nav'
        end

        describe 'logo link' do
          it 'exists' do
            expect(page).to have_link 'What\'s For Lunch?'
          end

          context 'on click' do
            it 'redirects to home page' do
              click_link 'What\'s For Lunch?'
              expect(current_path).to eq '/'
            end
          end
        end

        describe 'login link' do
          it 'exists' do
            expect(page).to have_link 'Log in'
          end

          context 'on click' do
            it 'redirects to the login page' do
              click_link 'Log in'
              expect(current_path).to eq '/users/sign_in'
            end
          end
        end
      end

      context 'when logged in' do
        before(:each) do
          login user
          visit @path
        end

        it 'has a nav' do
          expect(page).to have_css 'nav'
        end

        describe 'logo link' do
          it 'exists' do
            expect(page).to have_link 'What\'s For Lunch?'
          end

          context 'on click' do
            it 'redirects to home page' do
              click_link 'What\'s For Lunch?'
              expect(current_path).to eq '/'
            end
          end
        end

        describe 'logout link' do
          it 'exists' do
            expect(page).to have_link 'Log out'
          end

          context 'on click' do
            it 'redirects to the home page' do
              click_link 'Log out'
              expect(current_path).to eq '/'
            end
          end
        end

        describe 'admin link' do
          it 'exists' do
            expect(page).to have_link 'Admin'
          end

          context 'on click' do
            it 'redirects to restaurants index page' do
              click_link 'Admin'
              expect(current_path).to eq '/restaurants'
            end
          end
        end
      end
    end
  end
end
