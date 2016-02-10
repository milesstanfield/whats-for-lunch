require 'spec_helper'

describe Visit do
  subject(:visit){ FactoryGirl.create(:visit, time: now_time) }

  describe 'attributes' do
    it_has_attributes 'restaurant_id', 'user_id', 'time'
  end
end
