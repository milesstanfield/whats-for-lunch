module StarRatingsHelper
  def star_states(average_rating)
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

  def star_data(state, index, current_user, restaurant, signed_in)
    rating = user_rating(restaurant, current_user, signed_in)
    data = {
      name: restaurant.name,
      last_visited: restaurant.last_visited,
      value: ((index + 1) - 6).abs,
      user_id: user_id(current_user, signed_in),
      id: restaurant.id,
      action: (rating ? 'update' : 'create')
    }
    {type: 'star', class: star_class(state, rating, index), data: data}
  end

  private

  def star_class(state, user_rating, index)
    if user_rating && (user_rating.value >= ((index + 1) - 6).abs)
      'star-voted'
    elsif state
      'star-selected'
    else
      'star'
    end
  end

  def user_rating(restaurant, current_user, signed_in)
    restaurant.user_rating(current_user) if signed_in
  end

  def user_id(current_user, signed_in)
    current_user.id if signed_in
  end
end
