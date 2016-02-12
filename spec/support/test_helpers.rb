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
    select '5', from: 'rating_value'
    fill_in 'restaurant_last_visited', with: '01/04/2016'
    click_button 'Create Restaurant'
  end

  def now_time
    Time.parse('2016-02-09 23:41:47 -0500')
  end

  def create_restaurants_ratings(user = FactoryGirl.create(:user))
    oldest_restaurant = FactoryGirl.create(:restaurant, name: 'oldest', last_visited: TimeFormatter.visit_time(now_time - 2.days))
    older_restaurant = FactoryGirl.create(:restaurant, name: 'older', last_visited: TimeFormatter.visit_time(now_time - 1.days))
    newest_restaurant = FactoryGirl.create(:restaurant, name: 'newest', last_visited: TimeFormatter.visit_time(now_time))
    oldest_restaurant.ratings << FactoryGirl.create(:rating, user_id: user.id)
    older_restaurant.ratings << FactoryGirl.create(:rating, user_id: user.id)
    newest_restaurant.ratings << FactoryGirl.create(:rating, user_id: user.id)
  end

  def create_path_from_destination!(destination, user)
    Restaurant.delete_all
    restaurant = FactoryGirl.create(:restaurant)
    restaurant.ratings << FactoryGirl.create(:rating, user_id: user.id)

    case destination
    when '/restaurants/:id'
      @path = "/restaurants/#{restaurant.id}"
    when '/restaurants/:id/edit'
      @path = "/restaurants/#{restaurant.id}/edit"
    else
      @path = destination
    end
  end

  def create_multi_user_restaurants(time = now_time)
    oldest_restaurant = FactoryGirl.create(:restaurant, name: 'oldest', last_visited: TimeFormatter.visit_time(time - 2.days))
    older_restaurant = FactoryGirl.create(:restaurant, name: 'older', last_visited: TimeFormatter.visit_time(time - 1.days))
    newest_restaurant = FactoryGirl.create(:restaurant, name: 'newest', last_visited: TimeFormatter.visit_time(time))
    ancient_restaurant = FactoryGirl.create(:restaurant, name: 'ancient', last_visited: TimeFormatter.visit_time(time - 30.days))

    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user, email: 'foo@example.com')
    user3 = FactoryGirl.create(:user, email: 'foobar@example.com')
    user4 = FactoryGirl.create(:user, email: 'blah@example.com')

    oldest_restaurant.ratings << FactoryGirl.create(:rating, value: 5, user_id: user1.id)
    oldest_restaurant.ratings << FactoryGirl.create(:rating, value: 3, user_id: user2.id)
    oldest_restaurant.ratings << FactoryGirl.create(:rating, value: 1, user_id: user3.id)
    oldest_restaurant.ratings << FactoryGirl.create(:rating, value: 1, user_id: user4.id)

    ancient_restaurant.ratings << FactoryGirl.create(:rating, value: 5, user_id: user1.id)
    ancient_restaurant.ratings << FactoryGirl.create(:rating, value: 3, user_id: user2.id)
    ancient_restaurant.ratings << FactoryGirl.create(:rating, value: 1, user_id: user3.id)
    ancient_restaurant.ratings << FactoryGirl.create(:rating, value: 1, user_id: user4.id)

    older_restaurant.ratings << FactoryGirl.create(:rating, value: 4, user_id: user1.id)
    older_restaurant.ratings << FactoryGirl.create(:rating, value: 2, user_id: user2.id)

    newest_restaurant.ratings << FactoryGirl.create(:rating, value: 2, user_id: user1.id)
    newest_restaurant.ratings << FactoryGirl.create(:rating, value: 2, user_id: user2.id)
    newest_restaurant.ratings << FactoryGirl.create(:rating, value: 1, user_id: user3.id)
  end
end
