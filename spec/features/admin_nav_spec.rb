require 'spec_helper'
include AdminNavTestHelpers

describe 'admin nav', type: :feature do
  admin_nav_expectations '/restaurants'
  admin_nav_expectations '/restaurants/new'
  admin_nav_expectations '/restaurants/:id'
  admin_nav_expectations '/restaurants/:id/edit'
end
