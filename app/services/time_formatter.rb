class TimeFormatter
  class << self

    def visit_time(time)
      time.strftime(strf)
    end

    def days_ago(visited_time, control_time = nil)
      control_time = control_time || Time.now
      parsed_visit_time = Time.strptime(visited_time, strf)
      (control_time - parsed_visit_time).to_i / 1.day
    end

    private

    def strf
      '%m/%d/%Y'
    end
  end
end
