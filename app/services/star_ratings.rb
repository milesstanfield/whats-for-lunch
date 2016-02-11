class StarRatings
  def self.options(average_rating)
    5.times.each.inject([]) do |array, index|
      case average_rating
      when 0
        array << false
      when 1
        array << ((index >= 4) ? true : false)
      when 2
        array << ((index >= 3) ? true : false)
      when 3
        array << ((index >= 2) ? true : false)
      when 4
        array << ((index >= 1) ? true : false)
      else
        array << true
      end
    end
  end
end
