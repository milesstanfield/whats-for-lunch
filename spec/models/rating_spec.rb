require 'spec_helper'

describe Rating do
  describe 'attributes' do
    it_has_attributes 'value', 'restaurant_id', 'user_id'
  end
end
