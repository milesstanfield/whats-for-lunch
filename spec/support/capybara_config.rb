require 'capybara'
require 'capybara/rspec'

Capybara.javascript_driver = :webkit
Capybara.ignore_hidden_elements = true

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
