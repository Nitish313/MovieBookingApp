class MoviesController < ApplicationController
  before_action :is_admin_user, except: :index
  before_action :find_movie, only: %i[destroy show edit update]

  def index
    @movies = Movie.latest_movies
  end

  def show
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
      flash.now[:alert] = 'Movie could not be saved'
      render :new
    end
  end

  def edit
  end

  def update
    if @movie.valid?
      @movie.save!
      show_timing_params = prepare_show_timing_params(movie_params[:show_timings])
      @movie.show_timings.destroy_all
      @movie.show_timings.upsert_all(show_timing_params)
      flash[:notice] = 'Movie updated succcessfully'
      redirect_to movie_path
    else
      flash.now[:alert] = 'Movie could not be saved'
      render :edit
    end
  end

  def destroy
    if @movie.present?
      @movie.destroy
      flash[:notice] = "#{@movie.title} is removed"
    else
      flash[:alert] = 'Something went wrong'
    end

    redirect_to movies_path
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :genre, show_timings: [])
  end

  def is_admin_user
    unless current_user.admin?
      flash[:alert] = "You don't have admin proviledges"
      redirect_to movies_path
    end
  end

  def prepare_show_timing_params(show_timings)
    show_timings.map {|show_time| {show_time:}}
  end

  def find_movie
    @movie = Movie.includes(:show_timings).find(params[:id])
  end
end