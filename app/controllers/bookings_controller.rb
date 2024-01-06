class BookingsController < ApplicationController
  before_action :user_signed_in?
  before_action :find_movie_and_show_timing

  def new
    @booking = Booking.new
  end

  def create
    updated_params = prepare_params(booking_params[:seat_number])
    Booking.upsert_all(updated_params)
  end

  private
  def booking_params
    params.require(:booking).permit(seat_number: [])
  end

  def find_movie_and_show_timing
    return false unless @movie = Movie.find(movie_id: params[:movie_id])
    return false unless @show_timing = ShowTiming.find!(show_timing_id: params[:show_timing_id])
  end

  def prepare_params(seat_numbers)
    seat_numbers.map {|seat_number| { seat_number:, movie_id: @movie.id, show_timing_id: @show_timing.id }}
  end
end
