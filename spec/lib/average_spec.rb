require 'spec_helper'
require 'average'
include Average

describe Average do
  describe '.find(sum, count)' do
    it 'returns rounded average' do
      expect(Average.find(21, 9)).to eq 2
    end
  end
end
