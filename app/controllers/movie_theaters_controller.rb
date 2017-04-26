class MovieTheatersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

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

  private

  def movie_theater_params
    params.require(:movie_theater).permit(:name, :address, :city, :state_id, :zipcode, :website)
  end
end
