
if Rails.env.development?
  FactoryGirl.create(:user)
end

puts 'done'
