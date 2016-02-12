$(document).ready(function(){
  var starSelector = '[type=\'star\']'
  var star = $(starSelector);

  star.click(function(event){
    event.preventDefault();
    var verb = $(this).attr('action-verb')
    var id = $(this).data('id')
    var name = $(this).data('name')
    var lastVisited = $(this).data('lastVisited')
    var value = $(this).data('value')
    var userId = $(this).data('userId')
    var action = $(this).data('action')
    var data = {restaurant: {name: name, last_visited: lastVisited}, rating: {value: value, user_id: userId}, id: id}
    var familyStars = $(this).closest('[name=\'card\']').find(starSelector)

    $.each(familyStars, function(index, star){
      if (value >= $(star).data('value')) {
        $(star).removeClass('star').removeClass('star-selected').addClass('star-voted')
      } else {
        $(star).removeClass('star-voted').removeClass('star-selected').addClass('star')
      }
    });

    $.ajax({
      url: ('/restaurants/' + action),
      type: 'POST',
      data: data,
      dataType: 'script'
    });
  });
});
