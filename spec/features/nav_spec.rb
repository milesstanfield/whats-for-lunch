require 'spec_helper'
include NavTestHelpers

describe 'nav', type: :feature do
  nav_expectations '/'
  nav_expectations '/users/sign_in'
  nav_expectations '/restaurants'
  nav_expectations '/restaurants/new'
  nav_expectations destination: '/restaurants/:id'
  nav_expectations destination: '/restaurants/:id/edit'
end
