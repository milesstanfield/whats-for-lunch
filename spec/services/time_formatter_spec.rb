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

  describe '.parsed_visit_time(visited_time)' do
    it 'returns time object from strftime string' do
      expect(TimeFormatter.parsed_visit_time('02/05/2016').to_s).to eq '2016-02-05 00:00:00 -0500'
    end
  end
end
