require 'spec_helper'

describe StarRatings do
  describe '.options' do
    context 'when average_rating == 1' do
      it 'returns formatted options for star ratings' do
        expect(StarRatings.options(1)).to eq [false, false, false, false, true]
      end
    end

    context 'when average_rating == 3' do
      it 'returns formatted options for star ratings' do
        expect(StarRatings.options(3)).to eq [false, false, true, true, true]
      end
    end

    context 'when average_rating == 10' do
      it 'returns formatted options for star ratings' do
        expect(StarRatings.options(10)).to eq [true, true, true, true, true]
      end
    end
  end
end
