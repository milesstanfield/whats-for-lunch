if Rails.env.development?
  user = FactoryGirl.create(:user)

  15.times do
    restaurant = FactoryGirl.create(:restaurant, name: FFaker::Name.name, last_visited: TimeFormatter.visit_time(Time.now - 4.days))
    restaurant.ratings << FactoryGirl.create(:rating, user_id: user.id)
  end
end

puts 'done'
