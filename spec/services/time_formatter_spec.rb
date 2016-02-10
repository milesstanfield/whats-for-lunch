require 'spec_helper'

describe TimeFormatter do
  describe '.visit_time(time)' do
    it 'formats time' do
      expect(TimeFormatter.visit_time(now_time)).to eq '02/09/2016'
    end
  end
end
