class Api::V1::VotesController < Api::V1::ApiController
  before_action :authenticate_user!
  before_action :authorize_user

  def upvote
    @review = Review.find(vote_params[:review_id])
    @vote = Vote.find_by(user: current_user, review: @review)

    if @vote
      if @vote.helpful == true
        render_json("You can change your answer but you can't answer again.")
      else
        @vote.helpful = true
        @vote.save
        render_json("Thank you for your feedback!")
      end
    else
      @vote = Vote.create(user: current_user, review: @review, helpful: true)
      render_json("Thank you for your feedback!")
    end
  end

  def downvote
    @review = Review.find(vote_params[:review_id])
    @vote = Vote.find_by(user: current_user, review: @review)

    if @vote
      if @vote.helpful == false
        render_json("You can change your answer but you can't answer again.")
      else
        @vote.helpful = false
        @vote.save
        render_json("Thank you for your feedback!")
      end
    else
      @vote = Vote.create(user: current_user, review: @review, helpful: false)
      render_json("Thank you for your feedback!")
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:review_id)
  end

  def authorize_user
    review = Review.find(vote_params[:review_id])
    if current_user == review.user
      flash[:alert] = "You can't vote on your own reviews."
      redirect_to review.movie_theater
    end
  end

  def render_json(message)
    render json: {
      helpfulVotes: @review.helpful_votes,
      voteMessage: message,
      reviewID: @review.id
    }, status: :created
  end
end
