class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @movie_theater = MovieTheater.find(params[:movie_theater_id])
    @review = Review.new
  end

  def create
    @movie_theater = MovieTheater.find(params[:movie_theater_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @movie_theater.reviews << @review

    if @review.save
      redirect_to @movie_theater, notice: 'Thank you for reviewing this theater!'
    else
      flash.now[:alert] = @review.errors.full_messages
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :body)
  end
end
