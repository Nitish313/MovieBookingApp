class MoviesController < ApplicationController
  before_action :is_admin_user, except: :index

  def index
    @movies = Movie.latest_movies
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params.except(:show_timings))
    
    if @movie.valid?
      @movie.save!
      show_timing_params = prepare_show_timing_params(movie_params[:show_timings])
      @movie.show_timings.upsert_all(show_timing_params)
      redirect_to authenticated_root_path
    else
      render :new
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :genre, show_timings: [])
  end

  def is_admin_user
    current_user.admin?
  end

  def prepare_show_timing_params(show_timings)
    show_timings.map {|show_time| {show_time:}}
  end
end