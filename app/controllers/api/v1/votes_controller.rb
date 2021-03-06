class Api::V1::VotesController < Api::V1::ApiController
  before_action :authenticate_user!
  before_action :define_review_and_vote

  def upvote
    if current_user == @review.user
      render_json("You can't vote on your own reviews.", upvote_api_v1_votes_path)
    elsif @vote
      if @vote.helpful == true
        render_json("You can change your answer but you can't answer again.", upvote_api_v1_votes_path)
      else
        @vote.helpful = true
        @vote.save
        render_json("Thank you for your feedback!", upvote_api_v1_votes_path)
      end
    else
      @vote = Vote.create(user: current_user, review: @review, helpful: true)
      render_json("Thank you for your feedback!", upvote_api_v1_votes_path)
    end
  end

  def downvote
    if current_user == @review.user
      render_json("You can't vote on your own reviews.", downvote_api_v1_votes_path)
    elsif @vote
      if @vote.helpful == false
        render_json("You can change your answer but you can't answer again.", downvote_api_v1_votes_path)
      else
        @vote.helpful = false
        @vote.save
        render_json("Thank you for your feedback!", downvote_api_v1_votes_path)
      end
    else
      @vote = Vote.create(user: current_user, review: @review, helpful: false)
      render_json("Thank you for your feedback!", downvote_api_v1_votes_path)
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:review_id)
  end

  def render_json(message, location)
    render json: {
      helpfulVotes: @review.helpful_votes,
      voteMessage: message,
      reviewID: @review.id
    }, status: :created, location: location
  end

  def define_review_and_vote
    @review ||= Review.find(vote_params[:review_id])
    @vote ||= Vote.find_by(user: current_user, review: @review)
  end
end
