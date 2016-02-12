require 'spec_helper'

describe Recommendations do
  before { create_multi_user_restaurants(Time.now) }
  subject(:recommendations){ Recommendations.fetch(Restaurant.all) }

  describe '.fetch(restaurants)' do
    it 'orders restaurants by their cumulative ratings' do
      recommendations.each_with_index do |recommendation, index|
        expect(recommendation[0]).to eq 2 if index == 0
        expect(recommendation[0]).to eq 2 if index == 1
      end
    end

    it 'doesnt include records with visit_dates < 3 days old' do
      newest = Restaurant.find_by_name('newest')
      newest_is_in_collection = recommendations.any? do |recommendation|
        recommendation[1].any? {|restaurant| restaurant == newest }
      end
      expect(newest_is_in_collection).to be false
    end

    it 'orders subsets of restaurants with same ratings by their date' do
      recommendations.each_with_index do |recommendation, index|
        if index == 1
          expect(recommendation[1].first.name).to eq 'ancient'
          expect(recommendation[1].last.name).to eq 'oldest'
        end
      end
    end
  end
end
