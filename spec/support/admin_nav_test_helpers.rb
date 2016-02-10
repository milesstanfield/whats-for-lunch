module AdminNavTestHelpers
  def admin_nav_expectations(destination)
    let(:user){ FactoryGirl.create(:user) }
    before(:each){ create_path_from_destination!(destination, user) }

    describe @path do
      before { login user }
      before(:each){ visit @path }

      it 'has a nav' do
        expect(page).to have_css admin_nav
      end

      describe 'restaurants link' do
        it 'exists' do
          within (admin_nav) do
            expect(page).to have_link 'Restaurants'
          end
        end

        context 'on click' do
          it 'redirects to restaurants index page' do
            within (admin_nav) do
              click_link 'Restaurants'
            end
            expect(current_path).to eq '/restaurants'
          end
        end
      end


      describe 'new restaurant link' do
        it 'exists' do
          within admin_nav do
            expect(page).to have_link 'New Restaurant'
          end
        end

        context 'on click' do
          it 'redirects to restaurants index page' do
            within admin_nav do
              click_link 'New Restaurant'
            end
            expect(current_path).to eq '/restaurants/new'
          end
        end
      end
    end
  end

  def admin_nav
    '[name=\'admin-nav\']'
  end
end
