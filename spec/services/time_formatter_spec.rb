require 'spec_helper'

describe TimeFormatter do
  describe '.visit_time(time)' do
    it 'formats time' do
      expect(TimeFormatter.visit_time(now_time)).to eq '02/09/2016'
    end
  end

  describe '.days_ago(formatted_time)' do
    it 'returns days since time argument' do
      control_time = Time.parse('2016-02-11 08:53:34 -0500')
      expect(TimeFormatter.days_ago('02/05/2016', control_time)).to eq 6
    end
  end
end
