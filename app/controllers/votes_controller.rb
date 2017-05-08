class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user
  before_action :find_or_create_vote

  def upvote
    if @vote.helpful == true
      flash[:alert] = "You can change your answer but you can't answer again."
    else
      @vote.helpful = true
      @vote.save
      flash[:notice] = "Thank you for your feedback!"
    end
    redirect_to @vote.review.movie_theater
  end

  def downvote
    if @vote.helpful == false
      flash[:alert] = "You can change your answer but you can't answer again."
    else
      @vote.helpful = false
      @vote.save
      flash[:notice] = "Thank you for your feedback!"
    end
    redirect_to @vote.review.movie_theater
  end

  private

  def authorize_user
    review = Review.find(params[:review_id])
    if current_user == review.user
      flash[:alert] = "You can't vote on your own reviews."
      redirect_to review.movie_theater
    end
  end

  def find_or_create_vote
    @vote = Vote.find_by(review_id: params[:review_id], user: current_user)
    if @vote.nil?
      @vote = Vote.new(review_id: params[:review_id], user: current_user)
    end
  end
end
