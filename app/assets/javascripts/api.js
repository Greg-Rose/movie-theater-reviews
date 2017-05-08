function postVote(reviewId, type) {
  var request = $.ajax({
    method: "POST",
    url: "/api/v1/votes/" + type,
    data: {
      vote: { review_id: reviewId }
    }
  });

  request.done(function(data) {
    var noun;
    if (data.helpfulVotes == 1) {
      noun = "person";
    } else {
      noun = "people";
    }
    $("#vote-total-" + data.reviewID).text(data.helpfulVotes + ' ' + noun + ' ' + 'found this review helpful.');
    $("#flash-container").text(data.voteMessage);
    $("#flash-container").addClass("alert alert-info");
  });
}
