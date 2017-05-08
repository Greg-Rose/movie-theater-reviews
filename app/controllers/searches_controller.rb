class SearchesController < ApplicationController
  def index
    search_query = params[:search]
    @movie_theaters = MovieTheater.where("lower(name) LIKE ?", "%#{search_query.downcase}%")
    if @movie_theaters.empty?
      @no_search_results = true
    end
    render "movie_theaters/index"
  end
end
