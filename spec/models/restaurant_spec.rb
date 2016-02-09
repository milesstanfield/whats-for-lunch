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

  describe 'validations' do
    it 'requires a name' do
      expect{FactoryGirl.create(:restaurant, name: nil)}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'must have a unique name' do
      FactoryGirl.create(:restaurant)
      expect{FactoryGirl.create(:restaurant)}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
