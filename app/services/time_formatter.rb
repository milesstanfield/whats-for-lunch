class TimeFormatter
  class << self

    def visit_time(time)
      time.strftime(strf)
    end

    def days_ago(visited_time, control_time = Time.now)
      (control_time - parsed_visit_time(visited_time)).to_i / 1.day
    end

    def parsed_visit_time(visited_time)
      Time.strptime(visited_time, strf)
    end

    private

    def strf
      '%m/%d/%Y'
    end
  end
end
