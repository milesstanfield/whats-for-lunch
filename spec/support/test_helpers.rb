module TestHelpers
  def it_has_attributes(*attributes)
    record = described_class.new
    attributes.each do |attribute|
      it "has #{attribute}" do
        expect{record.send(attribute)}.to_not raise_error
      end
    end
  end

  def login(user)
    visit '/users/sign_in'
    fill_in 'user_email', with: user.try('email')
    fill_in 'user_password', with: user.try('password')
    click_button 'Log in'
  end

  def fill_and_submit_new_restaurant_form(name = 'Chick-fil-a')
    fill_in 'restaurant_name', with: name
    click_button 'Create Restaurant'
  end

  def now_time
    Time.parse('2016-02-09 23:41:47 -0500')
  end

  def create_restaurants(user = FactoryGirl.create(:user))
    user.restaurants << FactoryGirl.create(:restaurant, name: 'oldest', created_at: now_time - 2.days)
    user.restaurants << FactoryGirl.create(:restaurant, name: 'older', created_at: now_time - 1.days)
    user.restaurants << FactoryGirl.create(:restaurant, name: 'newest', created_at: now_time)
  end

  def create_path_from_destination!(destination)
    Restaurant.delete_all
    restaurant = FactoryGirl.create(:restaurant)
    case destination
    when '/restaurants/:id'
      @path = "/restaurants/#{restaurant.id}"
    when '/restaurants/:id/edit'
      @path = "/restaurants/#{restaurant.id}/edit"
    else
      @path = destination
    end
  end

end
