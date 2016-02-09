require 'spec_helper'

describe Restaurant do
  subject(:restaurant){ Restaurant.new }

  describe 'attributes' do
    it_has_attributes 'name'
  end

  describe 'associations' do
    it 'has many ratings' do
      expect(restaurant.ratings).to eq []
    end
  end
end
