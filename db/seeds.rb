
if Rails.env.development?
  FactoryGirl.create(:user)
  5.times do
    FactoryGirl.create(:restaurant, name: FFaker::Name.name)
  end
end

puts 'done'
