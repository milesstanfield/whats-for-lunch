if Rails.env.development?
  user = FactoryGirl.create(:user)

  5.times do
    restaurant = FactoryGirl.create(:restaurant, name: FFaker::Name.name)
    user.restaurants << restaurant
    restaurant.ratings << FactoryGirl.create(:rating, user_id: user.id)
  end
end

puts 'done'
