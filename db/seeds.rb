if Rails.env.development?
  require "#{Rails.root}/spec/support/test_helpers.rb"
  include TestHelpers
  create_multi_user_restaurants
end

puts 'done'
