class MovieTheatersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update]

  def index
    @movie_theaters = MovieTheater.all
  end

  def show
    @movie_theater = MovieTheater.find(params[:id])
  end

  def new
    @states = State.all
    @movie_theater = MovieTheater.new
  end

  def create
    @movie_theater = MovieTheater.new(movie_theater_params)
    @movie_theater.user = current_user

    if @movie_theater.save
      redirect_to @movie_theater, notice: 'New Movie Theater Added!'
    else
      @states = State.all
      flash.now[:alert] = @movie_theater.errors.full_messages
      render :new
    end
  end

  def edit
    @states = State.all
    @movie_theater = MovieTheater.find(params[:id])
  end

  def update
    @movie_theater = MovieTheater.find(params[:id])
    if @movie_theater.update(movie_theater_params)
      redirect_to @movie_theater, notice: "Movie Theater Updated!"
    else
      @states = State.all
      flash.now[:alert] = @movie_theater.errors.full_messages
      render :edit
    end
  end

  private

  def movie_theater_params
    params.require(:movie_theater).permit(:name, :address, :city, :state_id, :zipcode, :website)
  end

  def authorize_user
    movie_theater = MovieTheater.find(params[:id])
    if !user_signed_in? || current_user != movie_theater.user
      redirect_to movie_theater, alert: "You Can Only Update Theaters You've Added!"
    end
  end
end
