class MovieTheatersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update]
  before_action :define_states, only: [:new, :create, :edit, :update]
  before_action :authorize_admin, only: [:destroy]

  def index
    @movie_theaters = MovieTheater.all
  end

  def show
    @movie_theater = MovieTheater.find(params[:id])
  end

  def new
    @movie_theater = MovieTheater.new
  end

  def create
    @movie_theater = MovieTheater.new(movie_theater_params)
    @movie_theater.user = current_user

    if @movie_theater.save
      redirect_to @movie_theater, notice: 'New Movie Theater Added!'
    else
      flash.now[:alert] = @movie_theater.errors.full_messages
      render :new
    end
  end

  def edit
    @movie_theater = MovieTheater.find(params[:id])
  end

  def update
    @movie_theater = MovieTheater.find(params[:id])
    if @movie_theater.update(movie_theater_params)
      redirect_to @movie_theater, notice: "Movie Theater Updated!"
    else
      flash.now[:alert] = @movie_theater.errors.full_messages
      render :edit
    end
  end

  def destroy
    @movie_theater = MovieTheater.find(params[:id])
    @movie_theater.destroy
    flash[:notice] = "Movie Theater Deleted."
    redirect_to movie_theaters_path
  end

  private

  def define_states
    @states ||= State.all
  end

  def movie_theater_params
    params.require(:movie_theater).permit(:name, :address, :city, :state_id, :zipcode, :website)
  end

  def authorize_user
    movie_theater = MovieTheater.find(params[:id])
    if !user_signed_in? || current_user != movie_theater.user
      redirect_to movie_theater, alert: "You Can Only Update Theaters You've Added!"
    end
  end

  def authorize_admin
    if !current_user || !current_user.admin?
      redirect_to root_path
    end
  end
end
