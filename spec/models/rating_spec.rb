require 'spec_helper'

describe Rating do
  subject(:rating){ FactoryGirl.create(:rating) }

  describe 'attributes' do
    it_has_attributes 'value', 'restaurant_id', 'user_id'
  end

  describe '.available_values' do
    it 'returns array of available rating values' do
      expect(Rating.available_values).to eq [0, 1, 2, 3, 4, 5]
    end
  end

  describe '.value_in_words' do
    it 'returns a formatted string of rating value' do
      expect(rating.value_in_words).to eq '1 of 5'
    end
  end

  describe '.value' do
    it 'defaults to 0' do
      rating = Rating.create
      expect(rating.value).to eq 0
    end
  end
end
