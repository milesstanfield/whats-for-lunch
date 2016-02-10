class TimeFormatter
  def self.visit_time(time)
    time.strftime('%m/%d/%Y')
  end
end
