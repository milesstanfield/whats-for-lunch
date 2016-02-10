if Rails.env.development?
  user = FactoryGirl.create(:user)

  15.times do
    restaurant = FactoryGirl.create(:restaurant, name: FFaker::Name.name)
    user.restaurants << restaurant
    restaurant.ratings << FactoryGirl.create(:rating, user_id: user.id)
    restaurant.visits << FactoryGirl.create(:visit, user_id: user.id, time: TimeFormatter.visit_time(Time.now))
  end
end

puts 'done'
