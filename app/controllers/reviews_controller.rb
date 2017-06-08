class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user_for_edit, only: [:edit, :update]
  before_action :authorize_user_for_new, only: [:new, :create]
  before_action :authorize_admin, only: [:destroy]

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

  def edit
    @movie_theater = MovieTheater.find(params[:movie_theater_id])
    @review = Review.find(params[:id])
  end

  def update
    @movie_theater = MovieTheater.find(params[:movie_theater_id])
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to @movie_theater, notice: "Review Updated!"
    else
      flash.now[:alert] = @review.errors.full_messages
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @movie_theater = @review.movie_theater
    @review.destroy
    redirect_to @movie_theater, notice: "Review Deleted."
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :rating)
  end

  def authorize_user_for_new
    movie_theater = MovieTheater.find(params[:movie_theater_id])
    if !movie_theater.reviews.where(user: current_user).empty?
      redirect_to movie_theater, alert: "You Can Only Review A Theater Once."
    end
  end

  def authorize_user_for_edit
    review = Review.find(params[:id])
    if current_user != review.user
      movie_theater = MovieTheater.find(params[:movie_theater_id])
      redirect_to movie_theater, alert: "You Can Only Update Reviews You've Written."
    end
  end

  def authorize_admin
    if !current_user || !current_user.admin?
      redirect_to root_path
    end
  end
end
